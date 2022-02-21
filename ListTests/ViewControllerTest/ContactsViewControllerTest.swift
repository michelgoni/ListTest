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
import DomainLayer

class ContactsViewControllerTest: QuickSpec {
    
    var sut: ListContactsViewController!
    
    override func spec() {
        
        describe("Testing visual elements in Contacts view controller") {
            
            beforeEach {
                self.sut = self.makeSut()
                
            }
            
            describe("In the ListViewcontroller") {
                context("when page is loaded") {
                    it("the table view is not nil") {
                        expect( self.sut.tableView).notTo(beNil())
                    }
                }
            }
            
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the select contacts button is not nil") {
                        expect( self.sut.selectedButton).notTo(beNil())
                    }
                }
            }
            
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the select contacts button is not nil") {
                        expect( self.sut.selectedButton).notTo(beNil())
                    }
                }
            }
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the select button is not nil after viewDidLoad") {
                        let selectButtonIsSubView =  self.sut.selectedButton.isDescendant(of:  self.sut.view)
                        expect(selectButtonIsSubView).notTo(beNil())
                    }
                }
            }
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("The table view is not nil after viewDidLoad") {
                        let tableViewisSubview =  self.sut.tableView.isDescendant(of:  self.sut.view)
                        expect(tableViewisSubview).notTo(beNil())
                    }
                }
            }
            
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("Table view is not nil after viewDidLoad") {
                        let tableViewisSubview =  self.sut.tableView.isDescendant(of:  self.sut.view)
                        expect(tableViewisSubview).notTo(beNil())
                    }
                }
            }
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the tableView number of rows is working") {
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)
                        expect( self.sut.tableView.numberOfRows(inSection: 0)) == 2
                    }
                    
                }
            }
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the tableView number of sections is only one") {
                        expect(self.sut.tableView.numberOfSections) == 1
                    }
                    
                }
            }
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the tableview returns custom cell") {
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)
                        
                        let cell = self.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                        expect(cell).to(beAKindOf(ContactsTableViewCell.self))
                    }
                    
                }
            }
            
            describe("In the ListViewcontroller") {
                context("when the page is loaded") {
                    it("the set up for the cell is properly called") {
                        
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)
                        self.sut.tableView.register(MockContactCell.self, forCellReuseIdentifier: MockContactCell.identifier)
                        let cell = self.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockContactCell
                        
                        if let element = cell.element {
                            self.sut.viewModel.getContacts.elements.map{$0.first?.name}
                            .subscribe(onNext: { (name) in
                                expect(element.name) == name ?? ""
                            }).disposed(by: self.rx.disposeBag)
                        }
                    }
                    
                }
            }
            
            describe("In the ListViewcontroller") {
                context("after pressing a contact") {
                    it("the disclosure indicator changes") {
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)
                        self.sut.tableView.register(MockContactCell.self, forCellReuseIdentifier: MockContactCell.identifier)

                        self.sut.selectedButton.sendActions(for: .touchUpInside)
                        guard let cell = self.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MockContactCell else {
                            fail()
                            return
                        }

                        expect(cell.accessoryType) != .checkmark
                    }

                }
            }

            describe("In the ListViewcontroller") {
                context("when a contact is selected") {
                    it("modifies background button color") {
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)

                        self.sut.tableView.delegate?.tableView?(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        expect(self.sut.selectedButton.backgroundColor) == .primary
                    }

                }
            }

            describe("In the ListViewcontroller") {
                context(" after pressing one contact") {
                    it("Button is enabled") {
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)

                        self.sut.tableView.delegate?.tableView?(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        expect(self.sut.selectedButton.isEnabled).to(beTrue())
                    }

                }
            }

            describe("In the ListViewcontroller") {
                context("when table view is loaded") {
                    it("Button is not enabled ") {
                        let _ = Observable.merge(self.sut.viewModel.getContacts.elements,
                                                 self.sut.viewModel.updatedContacts.elements)

                        expect(self.sut.selectedButton.isEnabled).notTo(beTrue())
                    }

                }
            }

            describe("In the ListViewcontroller") {
                context("after selecting one contact") {
                    it("Button text is modified ") {

                        self.sut.viewModel.updatedContacts.inputs.onNext((contact: ContactsFake.contactSelected, contacts: ContactsFake.contactsSelected))
                        expect(self.sut.selectedButton.titleLabel?.text) == "1 element selected"
                    }

                }
            }

            describe("In the ListViewcontroller") {
                context("when a query string is passed") {
                    it("tableView number is rows is working ") {
                        self.sut.viewModel.searchContacts.inputs.onNext("Hulk")
                        expect(self.sut.tableView.numberOfRows(inSection: 0)).notTo(beNil())
                    }

                }
            }
            afterEach {
                self.sut = nil
            }
        }
        
    }
    
    private func makeSut() -> ListContactsViewController {
        let viewModel  = ContactsMockViewModel()
        let nav = Scene.contacts(viewModel).viewController() as! UINavigationController
        let sut = nav.viewControllers.first as! ListContactsViewController
        
        sut.loadViewIfNeeded()
        
        return sut
    }
}

private  class ContactsMockViewModel: ContactsViewModel {
    
    
    var offset: Int = 10
    

    
    lazy var searchContacts: Action<String, [Contact]> = { _ in
        Action<String, [Contact]> { this in
            
            return .just(ContactsFake.searchContacts)
        }
        
    }(self)

    lazy var getContacts: Action<Void, [Contact]> = { _ in
        Action <Void, [Contact]> {
           
            return .just(ContactsFake.contacts)
        }
    }(self)
    
    lazy var loadNextPageContacts: Action<Void, [Contact]> = { _ in
        Action<Void, [Contact]> { this in
            
            return .just(ContactsFake.searchContacts)
        }
        
    }(self)
    
    lazy var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> = { _ in
        
        Action<(contact: Contact, contacts: [Contact]), [Contact]> { _ in
            return .just(ContactsFake.contactsSelected)
        }
        
    }(self)
    
    lazy var selectedContacts: Action<[Contact], Void> = { _ in
        Action<[Contact], Void> { _ in
            return .empty()
        }
    }(self)
    
    lazy var resetContacts: CocoaAction = { _ in
        CocoaAction { _ in
            return .empty()
        }
    }(self)
    
}

private class MockContactCell: ContactsTableViewCell {
    
    let identifier = "MockContactCell"
    var element: ContactRepresentable?
    var accesoryTypeElement = ""
    
    override func setup(with data: Any) {
        
        guard let contactElement = data as? ContactRepresentable else {return}
        accessoryType = contactElement.isSelected ? .checkmark : .none
        element = contactElement
    }
}
