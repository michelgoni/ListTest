//
//  ContactsViewControllerTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 19/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
@testable import List
import Quick
import Nimble
import RxSwift
import RxCocoa
import Action
import RxTest

class ContactsViewControllerTest: QuickSpec {
    
    override func spec() {
        
        describe("Testing visual elements in Contacts view controller") {
            
            var sut: ListContactsViewController!
            var viewModel: ContactsMockViewModel!
            var tableView: UITableView!
            
            beforeEach {
                viewModel  = ContactsMockViewModel()
                sut = Scene.contacts(viewModel).viewController() as? ListContactsViewController
                sut.loadViewIfNeeded()
                tableView = sut.tableView
            }
            
            it("Table view is not nil") {
                expect(sut.tableView).notTo(beNil())
            }
            
            it("Select contacts button is not nil") {
                expect(sut.selectedButton).notTo(beNil())
            }
            
            it("Select button is not nil after viewDidLoad") {
                let selectButtonIsSubView = sut.selectedButton.isDescendant(of: sut.view)
                expect(selectButtonIsSubView).notTo(beNil())
            }
            
            it("Table view is not nil after viewDidLoad") {
                let tableViewisSubview = sut.tableView.isDescendant(of: sut.view)
                expect(tableViewisSubview).notTo(beNil())
            }
            
            it("TableView number is rows is working") {
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                expect(sut.tableView.numberOfRows(inSection: 0)) == 2
            }
            
            it("TableView number of sections is only one") {
                expect(sut.tableView.numberOfSections) == 1
            }
            
            it("Tableview returns custom cell") {
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                
                let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(ContactsTableViewCell.self))
            }
            
            it("Set up for cell is properly called") {
                
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                sut.tableView.register(MockContactCell.self, forCellReuseIdentifier: MockContactCell.identifier)
                let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockContactCell
                
                if let element = cell.element {
                    viewModel.getContacts.elements.map{$0.first?.name}
                        .subscribe(onNext: { (name) in
                        expect(element.name) == name ?? ""
                    }).disposed(by: self.rx.disposeBag)
                }
            }
            
            it("Disclosure indicator changes after pressing a contact") {
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                  sut.tableView.register(MockContactCell.self, forCellReuseIdentifier: MockContactCell.identifier)
                
                sut.selectedButton.sendActions(for: .touchUpInside)
                guard let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MockContactCell else {
                    fail()
                    return
                }

                expect(cell.accessoryType) != .checkmark
            }
            
            it("Modifies background button color after selecting one contact") {
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                
                sut.tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                expect(sut.selectedButton.backgroundColor) == .primary
            }
            
            it("Button is enabled after pressing one contact") {
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                
                sut.tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                expect(sut.selectedButton.isEnabled).to(beTrue())
            }
            
            it("Button is not enabled when loading table view") {
                let _ = Observable.merge(viewModel.getContacts.elements,
                                         viewModel.updatedContacts.elements)
                
                expect(sut.selectedButton.isEnabled).notTo(beTrue())
            }
            
            it("Button text is modified after selecting one contact") {
                
                sut.viewModel.updatedContacts.inputs.onNext((contact: ContactsFake.contactSelected, contacts: ContactsFake.contactsSelected))
                
                expect(sut.selectedButton.titleLabel?.text) == "1 element selected"
                
   
            }
            
            class MockContactCell: ContactsTableViewCell {
                
                let identifier = "MockContactCell"
                var element: ContactRepresentable?
                var accesoryTypeElement = ""
                
                override func setup(with data: Any) {
                    
                    guard let contactElement = data as? ContactRepresentable else {return}
                    accessoryType = contactElement.isSelected ? .checkmark : .none
                    element = contactElement
                }
            }
            
            class ContactsMockViewModel: ContactsViewModel {
               
                
                var detailContactCalled = false
                
                lazy  var getContacts: Action<Void, [Contact]> = { _ in
                    Action <Void, [Contact]> {
                        let contact = [Contact(name: "", image: "", isSelected: true)]
                        return .just(ContactsFake.contacts)
                    }
                }(self)
                
                lazy var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> = { _ in
                    
                    Action<(contact: Contact, contacts: [Contact]), [Contact]> { _ in
                        return .just(ContactsFake.contactsSelected)
                    }
                    
                }(self)
                
                lazy var selectedContacts: Action<Observable<[Contact]>, Void> = { _ in
                    Action<Observable<[Contact]>, Void> { _ in
                        self.detailContactCalled = true
                        return .empty()
                    }
                }(self)
                
            }
        }
    }
}
