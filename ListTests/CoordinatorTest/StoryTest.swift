//
//  StoryTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 18/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
import Quick
import Nimble
import List
import DomainLayer
import DataLayer
import RxSwift
import Action

class StoryTest: QuickSpec {
    
    fileprivate var testElement: (sut: SceneCoordinator, mockContactsUseCase: MockContactsUseCase)!
    override func spec() {
        beforeEach {
            self.testElement = self.makeSut()
        }
        
        describe("The coordinator implementation") {
            context("after view is loaded") {
                it("retrieves a ListContactsViewController") {
                    
                    let viewModel = MockViewModel(mockContactsUseCase: self.testElement.mockContactsUseCase,
                                                  sut: self.testElement.sut)
                    let viewController = Scene.contacts(viewModel).viewController() as? UINavigationController
                    
                    let finalVC = viewController!.viewControllers.first as! ListContactsViewController
                    finalVC.loadViewIfNeeded()
                    expect(finalVC).to(beAKindOf(ListContactsViewController.self))
                }
            }
        }
        afterEach {
            self.testElement = nil
        }
    }
    
    private func makeSut() -> (sut: SceneCoordinator, mockContactsUseCase: MockContactsUseCase) {
        let sut = SceneCoordinator()
        let useCase = MockContactsUseCase()
        self.testElement = (sut, useCase)
        return self.testElement
    }
}

private class MockContactsUseCase: ContactsUseCase {
    func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>> {
        .just(.success([]))
    }
    
    func searchContacts(query: String) -> Single<Result<[Contact], DomainError>> {
        .just(.success([]))
    }
}

private class MockViewModel: ContactsViewModel {
    
    var offset: Int = 0
    var mockContactsUseCase: MockContactsUseCase
    var sut: SceneCoordinator
    
    init(mockContactsUseCase: MockContactsUseCase, sut: SceneCoordinator) {
        self.mockContactsUseCase = mockContactsUseCase
        self.sut = sut
    }
    
    var getContacts: Action<Void, [Contact]> {
        Action <Void, [Contact]> {
            .just(ContactsFake.contacts)
        }
    }
    var loadNextPageContacts: Action<Void, [Contact]> {
        Action <Void, [Contact]> {
            .just(ContactsFake.contacts)
        }
    }
    var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> {
        Action<(contact: Contact, contacts: [Contact]), [Contact]> { _ in
            return .just(ContactsFake.contactsSelected)
        }
    }
    var selectedContacts: Action<[Contact], Void> {
        Action<[Contact], Void> { _ in
            return .empty()
        }
    }
    var resetContacts: CocoaAction {
        CocoaAction { _ in
            return .empty()
        }
    }
    var searchContacts: Action<String, [Contact]> {
        Action<String, [Contact]> { this in
            return .just(ContactsFake.searchContacts)
        }
    }
}
