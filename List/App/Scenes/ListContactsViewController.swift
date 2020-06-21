//
//  ListContactsViewController.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx


class ListContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    // MARK: Dispose Bag
    private let bag = DisposeBag()
    
    // MARK: ViewModel
    var viewModel: ContactsViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Private
    private func setupTableView() {
        let contactCellNib = UINib(nibName: ContactsTableViewCell.nibName, bundle: .main)
        tableView.register(contactCellNib, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        
    }
}



extension ListContactsViewController: Bindable {
    
    func bind() {
        bindTableView()
        viewModel.contacts.execute()
    }
    
    private func bindTableView() {
        let data = viewModel.contacts.elements
       data.bind(to:
            tableView.rx.items(
                cellIdentifier: String(describing: ContactsTableViewCell.self),
                cellType: ContactsTableViewCell.self)
            ) { _, model, cell in
                debugPrint(model)
            }
        .disposed(by: rx.disposeBag)
    }
    
    
}


