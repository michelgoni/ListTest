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

    override func spec() {
        
        describe("Contacts View model implementation") {
            var sut: ContactsViewModel!
            var coordinator: MockCoordinator!
            var useCase: MockContactsUseCase!
            
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!
            
            
            beforeEach {
                coordinator = MockCoordinator()
                useCase = MockContactsUseCase()
                sut = ContactsViewModelImplm(useCase: useCase, coordinator: coordinator)
                sut.offset = 10
                scheduler = TestScheduler(initialClock: 0)
                disposeBag = DisposeBag()
            }
            
            it("Gets initial Contacts for testing purpose") {
                expect(ContactsFake.contacts).notTo(beNil())
            }
            
            it("Updates selected contacts") {
               
                let selectedElement = scheduler.createObserver([Bool].self)
                
                sut.updatedContacts.elements
                    .map { $0.map{$0.isSelected}}
                    .bind(to: selectedElement)
                    .disposed(by: disposeBag)

                scheduler.createHotObservable([.next(10, (contact: ContactsFake.contactSelected, contacts: ContactsFake.contacts))])
                    .bind(to: sut.updatedContacts.inputs)
                    .disposed(by: disposeBag)
                
                scheduler.start()
                expect(selectedElement.events) == [.next(10, ContactsFake.contactsSelected.map{$0.isSelected})]
            }
            
            it("Gets contacts") {
                let contactName = scheduler.createObserver([String].self)
                
                sut.getContacts.elements.map { $0.map{$0.name}}
                    .bind(to: contactName)
                    .disposed(by: disposeBag)
                
                scheduler.createColdObservable([.next(10, ())])
                    .bind(to: sut.getContacts.inputs)
                    .disposed(by: disposeBag)
                
                scheduler.start()
                expect(contactName.events) == [.next(10, useCase.names.map{$0})]
            }
            
            it("Increments offset") {
                sut.loadNextPageContacts.execute()
                expect(sut.offset) == 20
            }
            
            
            it("Searches for a contact") {
                
                let searchResults = scheduler.createObserver([String].self)
                
                sut.searchContacts.elements
                    .map{$0.map{$0.name}}
                    .bind(to: searchResults)
                    .disposed(by: disposeBag)
                
                scheduler.createHotObservable([.next(10, ("Hulk"))])
                    .bind(to: sut.searchContacts.inputs)
                    .disposed(by: disposeBag)
                
                scheduler.start()
                
                expect(searchResults.events) == [.next(10, useCase.search.map{$0})]
            }
            
            it("Selects contacts for the Detail Contacts view controller") {
                
                sut.selectedContacts.inputs.onNext(ContactsFake.contactsSelected)
                expect(coordinator.areSelectedContacts).to(beTrue())
            }
            
            it("Selects contacts with one element as true") {
                
                sut.selectedContacts.inputs.onNext(ContactsFake.contactsSelected)
                sut.updatedContacts.elements
                    .map{$0.filter{$0.isSelected}}
                    .subscribe(onNext: { (contacts) in
                    expect(contacts).notTo(beNil())
                }).disposed(by: self.rx.disposeBag)
            }
            
            it("Transitions to the detail Contacts viewController") {
                
                sut.selectedContacts.inputs.onNext(ContactsFake.contacts)
                expect(coordinator.sceneTransitionCalled) == .modal
            }
        }
        
        class MockCoordinator: SceneCoordinator {
            
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
        
        class MockContactsUseCase: ContactsUseCase {
            
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
    }
}
