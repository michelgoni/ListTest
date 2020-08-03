//
//  SelectedContactsViewModelTest.swift
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

class SelectedContactsViewModelTest: QuickSpec {

    override func spec() {
        describe("Selected contacts view model test implementation") {
            var sut: DetailContactsViewModel!
            var coordinator: MockCoordinator!
            let resetContacts: CocoaAction = { _ in
                CocoaAction { _ in
                    return .empty()
                }
            }(self)
            
            beforeEach {
                coordinator = MockCoordinator()
                
                sut = DetailContacts(contacts: ContactsFake.contactsSelected,
                                     coordinator: coordinator,
                                     resetContacts: resetContacts)
            }
            
            it("Get contats from previous selection") {
                expect(sut.contacts).notTo(beNil())
            }
        }
    }
    
    class MockCoordinator: SceneCoordinator {
        
        var isPopCalled = false
        var sceneTransitionCalled: SceneTransitionType?
        
        override func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
            
            switch scene {
                
            case .contacts:
                isPopCalled = true
                
            case .selectedContacts:
               break
            }
            sceneTransitionCalled = type
            return .empty()
        }
    }

}
