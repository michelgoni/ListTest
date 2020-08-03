//
//  SelectedContactsViewControllerTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 03/08/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Quick
import Nimble
import Action
@testable import List

class SelectedContactsViewControllerTest: QuickSpec {

    override func spec() {
        describe("Selected contacts viewController test implementation") {
            var sut: SelectedContactsViewController!
            var nav: UINavigationController!
            var viewModel: MockSelectedContactsViewModel!
            var tableView: UITableView!
            
            beforeEach {
                viewModel = MockSelectedContactsViewModel()
                nav = Scene.selectedContacts(viewModel).viewController() as? UINavigationController
                sut = nav.viewControllers.first as? SelectedContactsViewController
                sut.loadViewIfNeeded()
                tableView = sut.tableView
            }
            
            it("Doesn´t load nil Table View for selected contacts") {
                expect(sut.tableView).notTo(beNil())
            }
            
            it("Doesn´t load nil Table View after viewDidLoad") {
                let tableViewisSubview = sut.tableView.isDescendant(of: sut.view)
                expect(tableViewisSubview).notTo(beNil())
            }
            
            it("Works tableView number of rows is working") {
                let _ = viewModel.contacts
                expect(sut.tableView.numberOfRows(inSection: 0)) == 2
            }
            
            it("Works TableView number of sections") {
                expect(sut.tableView.numberOfSections) == 1
            }
            
            it("returns a custom cell") {
                let _ = viewModel.contacts
                
                let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(ContactsTableViewCell.self))
            }
        }
    }
    
    class MockSelectedContactsViewModel: DetailContactsViewModel {
        
        var contacts = ContactsFake.contactsSelected
        
        var coordinator = SceneCoordinator()
        
        lazy var resetContacts: CocoaAction = { _ in
            
            CocoaAction { _ in
                return .empty()
            }
        }(self)
        
        lazy var dismiss: CocoaAction = { _ in
            CocoaAction { _ in
                return .empty()
            }
        }(self)
        
        
    }
    
    

}
