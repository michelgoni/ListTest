//
//  BaseviewController.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewProtocol {
    func showLoading()
    func hideLoading()
    func hideLoading(completion: (() -> Void)?)
}

public class BaseViewController: UIViewController {
    
    var loadingScreen = ActivityIndicatorScreen()
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let message = "Showing " + NSStringFromClass(self.classForCoder)
        debugPrint(message)
    }
    
    // MARK: BaseViewProtocol
    
    func showTitle(title: String) {
        self.title = title
    }
    
    func showLoading() {
        loadingScreen.show(view: view)
    }
    
    func hideLoading() {
        hideLoading(completion: nil)
    }
    
    // MARK: - Class functions
    
    func hideLoading(completion: (() -> Void)? = nil) {
        loadingScreen.hide(completion: completion)
    }
}
