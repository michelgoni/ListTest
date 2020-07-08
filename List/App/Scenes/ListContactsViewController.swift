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
import RxCocoa


class ListContactsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let elementsSubject = PublishSubject<[Contact]>()
    public var elements: AnyObserver<[Contact]> {
        return elementsSubject.asObserver()
    }
    
    private var selectedItemSubject = PublishSubject<Int>()
      public var selectedItem: Observable<Int> {
          selectedItemSubject.asObservable()
      }
    
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
        let contactCellNib = UINib(nibName: ContactsTableViewCell.nibName, bundle:nil)
        tableView.register(contactCellNib, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindTableView() {
        
       
        viewModel.getContacts.elements.bind(to:
            tableView.rx.items(
                cellIdentifier: ContactsTableViewCell.identifier,
                cellType: ContactsTableViewCell.self)
        ) { _, model, cell in
            cell.setup(with: model)
        }
        .disposed(by: bag)

    }
    
    private func bindTableViewSelection() {
        
        
    }
}

extension ListContactsViewController: Bindable {
    
    func bind() {
        
        bindTableView()
        bindTableViewSelection()
        viewModel.getContacts.execute()
        
    }
}
    
