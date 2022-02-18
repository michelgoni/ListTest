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
            
            guard let nc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? UINavigationController,
                    var vc = nc.viewControllers.first as? ListContactsViewController else {
                 fatalError("There should be a Storyboard with the name ListViewController or a ListContactsViewController")}
            
            
            vc.bind(to: viewModel)
            return nc
        case .selectedContacts(let selectedContacts):
            
            guard let nc = storyboard.instantiateViewController(withIdentifier: "FinalList") as? UINavigationController,
                    var detailVC = nc.viewControllers.first as? SelectedContactsViewController else {
                fatalError("There should be a Storyboard with the name FinalList or a ListContactsViewController")}
            
           
            detailVC.bind(to: selectedContacts)
            return nc
        }
    }
}
