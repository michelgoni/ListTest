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
        
        let mainViewController = ListContactsViewController()
        let contactsApiService = ContactsApiServiceImplm(apiService: SuperHeroApiClient())
        let repository = ContactsRepositoryImplm(contactsApiService: contactsApiService)
        let contactsUsecase = ContactsUseCaseImplm(repository:repository)
        
        let initialViewController = builder(contactsUsecase)
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
    }
    
    private func builder(_ useCase: ContactsUseCase) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listNavigation = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! UINavigationController
        
        
       
        return listNavigation
    }

}
