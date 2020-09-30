//
//  BaseviewController.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import UIKit


public class BaseViewController: UIViewController {
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let message = "Showing " + NSStringFromClass(self.classForCoder)
        debugPrint(message)
    }
    
    // MARK: BaseViewProtocol
    
    func showTitle(title: String) {
        self.title = title
    }
    
}
