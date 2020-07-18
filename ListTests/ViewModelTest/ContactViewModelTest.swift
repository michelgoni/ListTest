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
import List
import Quick
import Nimble

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
                sut = ContactsViewModelImplm(useCase: useCase)
                
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
        }
        
        class MockCoordinator: SceneCoordinator {
            
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
