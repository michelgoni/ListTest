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
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func bindButtonCancelAction() {
        cancelButton.rx.action = viewModel.dismiss
    }
    private func bindButtonOkAction() {
        
    }
}

extension SelectedContactsViewController: Bindable {
    
    func bind() {
        bindButtonCancelAction()
        bindButtonOkAction()
    }
}
