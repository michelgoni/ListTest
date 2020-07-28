//
//  SelectedContactsViewController.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit

class SelectedContactsViewController: BaseViewController {
    
 var viewModel: DetailContactsViewModel!
    
    @IBOutlet weak var okButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func okPressed(_ sender: Any) {
        
    }
    
    private func bindButtonAction() {
        okButton.rx.action = viewModel.dismiss
    }
    
}

extension SelectedContactsViewController: Bindable {
    
    func bind() {
        bindButtonAction()
    }
}
