//
//  SelectedContactsViewController.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit
import RxSwift

class SelectedContactsViewController: BaseViewController {
    
    var viewModel: DetailContactsViewModel!
    
    @IBOutlet weak var okButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureBlurredView()
    }
    
    private func configureBlurredView() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
        self.view.insertSubview(blurredEffectView, belowSubview: tableView)
    }
    
    private func configureTableView() {
        tableView.layer.cornerRadius = 15.0
        let contactCellNib = UINib(nibName: ContactsTableViewCell.nibName, bundle:nil)
        tableView.register(contactCellNib, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindButtonCancelAction() {
        cancelButton.rx.action = viewModel.dismiss
    }
    private func bindButtonOkAction() {
        okButton.rx.action = viewModel.resetContacts
    }
    
    private func bindTableView() {
        
        Observable.of(viewModel.contacts).bind(to:
            tableView.rx.items(
                cellIdentifier: ContactsTableViewCell.identifier,
                cellType: ContactsTableViewCell.self)
        ) { _, model, cell in
            cell.setup(with: model)
        }
        .disposed(by: rx.disposeBag)
    }
}

extension SelectedContactsViewController: Bindable {
    
    func bind() {
        bindButtonCancelAction()
        bindButtonOkAction()
        bindTableView()
    }
}
