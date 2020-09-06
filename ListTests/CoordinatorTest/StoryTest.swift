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
import TransportationApiClient

class StoryTest: QuickSpec {

    override func spec() {
        var coordinator: SceneCoordinator!
        var useCase: ContactsUseCase!
        var repository: ContactsRepository!
        
        beforeEach {
            coordinator = SceneCoordinator()
            repository = ContactsRepositoryImplm(contactsApiService: ContactsApiServiceImplm(apiService: APIClient()))
            useCase = ContactsUseCaseImplm(repository: repository)
        }
        
        describe("Coordinator is properly working") {
            it("Gets Contacts ViewController") {
                
                let viewModel = ContactsViewModelImplm(useCase: useCase, coordinator: coordinator)
                let viewController = Scene.contacts(viewModel).viewController() as? UINavigationController
                
                let finalVC = viewController!.viewControllers.first as! ListContactsViewController
                
                finalVC.loadViewIfNeeded()
                expect(finalVC).to(beAKindOf(ListContactsViewController.self))
            }
        }
    }

}
