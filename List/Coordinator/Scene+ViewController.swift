//
//  Scene+ViewController.swift
//  List
//
//  Created by Miguel Goñi on 14/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import UIKit

public extension Scene {
    
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch self {
        case .contacts(let viewModel):
            
            let listNavigation = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! UINavigationController
            var listViewController = listNavigation.viewControllers.first as! ListContactsViewController
            
            listViewController.bind(to: viewModel)
            return listViewController
        case .selectedContacts(let selectedContacts):
           
            var detailContacts = storyboard.instantiateViewController(withIdentifier: "SelectedContactsViewController")as! SelectedContactsViewController
            detailContacts.bind(to: selectedContacts)
            return detailContacts
        }
    }
    
}
