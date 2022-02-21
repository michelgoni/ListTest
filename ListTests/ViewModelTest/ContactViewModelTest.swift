//
//  ContactViewModelTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 18/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
import Quick
import Nimble
import DomainLayer

@testable import List

class ContactViewModelTest: QuickSpec {
    
    private var testingElements: (sut: ContactsViewModel, coordinator: MockCoordinator, useCase: MockContactsUseCase)!
    private var rxTestingElements: (scheduler: TestScheduler, disposeBag: DisposeBag)!
    
    override func spec() {
        
        
        beforeEach {
            self.testingElements = self.makeSut()
            self.rxTestingElements = self.makeRxTestingElements()
        }
        
        describe("The Contacts View model implementation") {
            context("for testing purpose") {
                it("gets initial Contacts for testing purpose") {
                    expect(ContactsFake.contacts).notTo(beNil())
                }
            }
        }
        
        describe("The Contacts View model implementation") {
            context("when the get contacts action is invoked") {
                it("receives contacts for the tableview to be pupulated") {
                    let contactName = self.rxTestingElements.scheduler.createObserver([String].self)
                    
                    self.testingElements.sut.getContacts.elements.map { $0.map{$0.name}}
                    .bind(to: contactName)
                    .disposed(by: self.rxTestingElements.disposeBag)
                    
                    self.rxTestingElements.scheduler.createColdObservable([.next(10, ())])
                        .bind(to: self.testingElements.sut.getContacts.inputs)
                        .disposed(by: self.rxTestingElements.disposeBag)
                    
                    self.rxTestingElements.scheduler.start()
                    expect(contactName.events) == [.next(10, self.testingElements.useCase.names.map{$0})]
                }
            }
        }
        
        describe("In the Contacts View model implementation") {
            context("when a contact is selected from the ListViewCOntroller") {
                it("updates selected contact value") {
                    
                    let selectedElement = self.rxTestingElements.scheduler.createObserver([Bool].self)
                    
                    self.testingElements.sut.updatedContacts.elements
                        .map { $0.map{$0.isSelected}}
                        .bind(to: selectedElement)
                        .disposed(by: self.rxTestingElements.disposeBag)
                    
                    self.rxTestingElements.scheduler.createHotObservable([.next(10, (contact: ContactsFake.contactSelected, contacts: ContactsFake.contacts))])
                        .bind(to: self.testingElements.sut.updatedContacts.inputs)
                        .disposed(by: self.rxTestingElements.disposeBag)
                    
                    self.rxTestingElements.scheduler.start()
                    expect(selectedElement.events) == [.next(10, ContactsFake.contactsSelected.map{$0.isSelected})]
                }
            }
        }
        
        describe("In the Contacts View model implementation") {
            context("when we´ve just reached the en of the page") {
                it("increments offset") {
                    self.testingElements.sut.loadNextPageContacts.execute()
                    expect(self.testingElements.sut.offset) == 20
                }
            }
        }
        
        describe("In the Contacts View model implementation") {
            context("when we invoke the search Action") {
                it("searches for a contact") {
                    
                    let searchResults = self.rxTestingElements.scheduler.createObserver([String].self)
                    
                    self.testingElements.sut.searchContacts.elements
                        .map{$0.map{$0.name}}
                        .bind(to: searchResults)
                        .disposed(by: self.rxTestingElements.disposeBag)
                    
                    self.rxTestingElements.scheduler.createHotObservable([.next(10, ("Hulk"))])
                        .bind(to: self.testingElements.sut.searchContacts.inputs)
                        .disposed(by: self.rxTestingElements.disposeBag)
                    
                    self.rxTestingElements.scheduler.start()
                    
                    expect(searchResults.events) == [.next(10, self.testingElements.useCase.search.map{$0})]
                }
            }
        }
        
        
        describe("In the Contacts View model implementation") {
            context("when a contact is selected in  ListViewController") {
                it("selects contacts for the Detail Contacts view controller") {
                    
                    self.testingElements.sut.selectedContacts.inputs.onNext(ContactsFake.contactsSelected)
                    expect(self.testingElements.coordinator.areSelectedContacts).to(beTrue())
                }
            }
        }
        
        describe("In the Contacts View model implementation") {
            context("when a contact is selected in ListViewController") {
                it("selects contact with one element as true") {
                    
                    self.testingElements.sut.selectedContacts.inputs.onNext(ContactsFake.contactsSelected)
                    self.testingElements.sut.updatedContacts.elements
                        .map{$0.filter{$0.isSelected}}
                        .subscribe(onNext: { (contacts) in
                            expect(contacts).notTo(beNil())
                        }).disposed(by: self.rx.disposeBag)
                }
            }
        }
        
        describe("In the Contacts View model implementation") {
            context("when the user presses the detail button") {
                it("transitions to the detail Contacts viewController") {
                    
                    self.testingElements.sut.selectedContacts.inputs.onNext(ContactsFake.contacts)
                    expect(self.testingElements.coordinator.sceneTransitionCalled) == .modal
                }
            }
        }
        
        afterEach {
            self.testingElements = nil
            self.rxTestingElements = nil
        }
        
    }
    
    private func makeSut() -> (sut: ContactsViewModel, coordinator: MockCoordinator, useCase: MockContactsUseCase){
        let coordinator = MockCoordinator()
        let useCase = MockContactsUseCase()
        let sut = ContactsViewModelImplm(useCase: useCase, coordinator: coordinator)
        sut.offset = 10
        return (sut, coordinator, useCase)
    }
    
    private func makeRxTestingElements() ->  (scheduler: TestScheduler, disposeBag: DisposeBag) {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        return (scheduler, disposeBag)
    }
}

private class MockCoordinator: SceneCoordinator {
    
    var areSelectedContacts = false
    var sceneTransitionCalled: SceneTransitionType?
    
    override func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        
        switch scene {
        case .contacts:
            break
            
        case .selectedContacts:
            areSelectedContacts = true
        }
        sceneTransitionCalled = type
        return .empty()
    }
}

private  class MockContactsUseCase: ContactsUseCase {
    
    var contacts = ContactsFake.contacts
    var searchContacts = ContactsFake.searchContacts
    
    var names: [String] {
        contacts.map{$0.name}
    }
    
    var search: [String] {
        searchContacts.map{$0.name}
    }
    
    func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>> {
        
        .just(.success(contacts))
    }
    func searchContacts(query: String) -> Single<Result<[Contact], DomainError>> {
        .just(.success([Contact(name: "Hulk", image: "", isSelected: false)]))
    }
}
