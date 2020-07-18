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
@testable import List

class ContactViewModelTest: QuickSpec {

    override func spec() {
        
       
        
        describe("View model implementation") {
            var sut: ContactsViewModel!
            var coordinator: MockCoordinator!
            var useCase: MockContactsUseCase!
            
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!
            
            
            beforeEach {
                coordinator = MockCoordinator()
                useCase = MockContactsUseCase()
                sut = ContactsViewModelImplm(useCase: useCase, coordinator: coordinator)
                
                scheduler = TestScheduler(initialClock: 0)
                disposeBag = DisposeBag()
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
            
            it("Selects contacts for the Detail Contacts view controller") {

                sut.selectedContacts.inputs.onNext(ContactsFake.contacts)
                expect(coordinator.areSelectedContacts).to(beTrue())
            }
            
            it("Transitions to the detail Contacts viewController") {
                
                sut.selectedContacts.inputs.onNext(ContactsFake.contacts)
                expect(coordinator.sceneTransitionCalled) == .push
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
            
            var names: [String] {contacts.map{$0.name}}
            
            func getContacts() -> Single<Result<[Contact], ErrorResponse>> {
                
                .just(.success(contacts))
            }
            
            
        }
        
        
    }

}
