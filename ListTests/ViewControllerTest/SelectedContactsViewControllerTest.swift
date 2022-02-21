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
    var testElements: (sut: SelectedContactsViewController, mockViewModel: MockSelectedContactsViewModel)!
    
    override func spec() {
        
        beforeEach {
            self.testElements = self.makeSut()
        }
        
        describe("In the SelectedViewcontroller") {
            
            context("When a contact is selected") {
                it("the tableView is not nil") {
                    expect(self.testElements.sut.tableView).notTo(beNil())
                }
            }
            
        }
        describe("In the SelectedViewcontroller") {
            
            context("after viewDidLoad") {
                it("the tableView is not nil") {
                    let tableViewisSubview = self.testElements.sut.tableView.isDescendant(of: self.testElements.sut.view)
                    expect(tableViewisSubview).notTo(beNil())
                }
            }
            
        }
        
        describe("In the SelectedViewcontroller") {
            
            context("after viewDidLoad is invoked") {
                it("load number of rows") {
                    let _ = self.testElements.mockViewModel.contacts
                    expect(self.testElements.sut.tableView.numberOfRows(inSection: 0)) == 2
                }
            }
        }
        
        describe("In the SelectedViewcontroller") {
            
            context("after viewDidLoad is invoked") {
                it("Woad number of sections") {
                    expect(self.testElements.sut.tableView.numberOfSections) == 1
                }
            }
        }
        
        describe("In the SelectedViewcontroller") {

            context("after the selected contacts are retrieved") {
                it("returns a custom cell") {
                    let _ = self.testElements.mockViewModel.contacts
                    let cell = self.testElements.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                    expect(cell).to(beAKindOf(ContactsTableViewCell.self))
                }
            }
        }
        
        describe("In the SelectedViewcontroller") {
            
            context("after the selected ontacts are retrieved") {
                it("Dismisses properly") {
                    self.testElements.sut.cancelButton.rx.action = self.testElements.sut.viewModel.dismiss
                    XCTAssertTrue(self.testElements.mockViewModel.dismissIsCalled == true)
                    
                }
            }
        }
        
        afterEach {
            self.testElements = nil
        }
    }
    
    private func makeSut() -> (sut: SelectedContactsViewController, mockViewModel: MockSelectedContactsViewModel) {
        let viewModel = MockSelectedContactsViewModel()
        let nav = Scene.selectedContacts(viewModel).viewController() as! UINavigationController
        let sut = nav.viewControllers.first as! SelectedContactsViewController
        sut.loadViewIfNeeded()
        return (sut, viewModel)
        
    }
    
}

class MockSelectedContactsViewModel: DetailContactsViewModel {
    
    var contacts = ContactsFake.contactsSelected
    var coordinator = SceneCoordinator()
    var dismissIsCalled = false
    
    lazy var resetContacts: CocoaAction = { _ in
        CocoaAction {
            .empty()
        }
    }(self)
    
    var dismiss: CocoaAction {
        
        self.dismissIsCalled = true
        return CocoaAction {
            
            .just(())
        }
    }
}
