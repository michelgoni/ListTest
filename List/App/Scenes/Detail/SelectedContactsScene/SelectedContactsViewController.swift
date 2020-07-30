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
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
        self.view.insertSubview(blurredEffectView, belowSubview: tableView)
        

    }
    
    private func configureTableView() {
        tableView.layer.cornerRadius = 15.0
    }
    
    private func bindButtonCancelAction() {
        cancelButton.rx.action = viewModel.dismiss
    }
    private func bindButtonOkAction() {
        okButton.rx.action = viewModel.resetContacts
    }
    
    private func bindTableView() {
        
    }
}

extension SelectedContactsViewController: Bindable {
    
    func bind() {
        bindButtonCancelAction()
        bindButtonOkAction()
        bindTableView()
    }
}
