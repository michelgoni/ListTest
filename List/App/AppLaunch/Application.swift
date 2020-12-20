//
//  Application.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit

final class Application {

    func start(with window: UIWindow) {
        
        let contactsApiService = ContactsApiServiceImplm()
        let repository = ContactsRepositoryImplm(contactsApiService: contactsApiService)
        let contactsUsecase = ContactsUseCaseImplm(repository:repository)
        
        let sceneCoordinator = SceneCoordinator(window: window)
        let viewModel = ContactsViewModelImplm(useCase: contactsUsecase, coordinator: sceneCoordinator)
        let firstScene = Scene.contacts(viewModel)
        sceneCoordinator.transition(to: firstScene, type: .root)

    }
}
