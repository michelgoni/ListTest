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
    
    var testingElements: (sut: DetailContactsViewModel, coordinator: DetailMockCoordinator)!
    
    override func spec() {
        
        beforeEach {
            self.testingElements = self.makeSut()
        }
        
        describe("When the selected viewModel implementation") {
            context("is instiantiated") {
                it("gets contacts from previous selection") {
                    expect(self.testingElements.sut.contacts).notTo(beNil())
                }
            }
        }
        
        describe("When the selected viewModel implementation") {
            context("is instiantiated") {
                it("at least there must be one element selected") {
                    expect(self.testingElements.sut.contacts.first?.isSelected).to(beTrue())
                }
            }
        }
        
        afterEach {
            self.testingElements = nil
        }
    }
  
    private func makeSut() -> (sut: DetailContactsViewModel, coordinator: DetailMockCoordinator) {
        
        let resetContacts: CocoaAction = { _ in
            CocoaAction { _ in
                return .empty()
            }
        }(self)
        
        let coordinator = DetailMockCoordinator()
        
        let sut = DetailContacts(contacts: ContactsFake.contactsSelected,
                             coordinator: coordinator,
                             resetContacts: resetContacts)
        
        return (sut, coordinator)
    }
}

class DetailMockCoordinator: SceneCoordinator {
    
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
