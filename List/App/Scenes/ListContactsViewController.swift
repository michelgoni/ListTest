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


class ListContactsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedButton: UIButton!
    
  
    
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
        
        let data = Observable.merge(viewModel.getContacts.elements, viewModel.updatedNames.elements)
        
        data.bind(to:
            tableView.rx.items(
                cellIdentifier: ContactsTableViewCell.identifier,
                cellType: ContactsTableViewCell.self)
        ) { _, model, cell in
            cell.setup(with: model)
        }
        .disposed(by: rx.disposeBag)
        
        let selectedData = tableView.rx.modelSelected(Contact.self).asObservable()
        let combinedData = Observable
            .combineLatest(data,selectedData)
            .map {(name: $1, names: $0)}
        
        tableView
            .rx
            .itemSelected
            .withLatestFrom(combinedData)
            .bind(to: viewModel.updatedNames.inputs)
            .disposed(by: rx.disposeBag)
        
        
    }
    
    private func bindTitle() {
        viewModel.selectedElements.elements
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: selectedButton.rx.title())
            .disposed(by: rx.disposeBag)

    }
    
    private func bindActivityIndicator() {
                
        Observable.merge(viewModel.getContacts.executing, viewModel.selectedElements.executing)
            .subscribe(onNext: { [weak self] (isLoading) in
            isLoading ? self?.showLoading() : self?.hideLoading()
        }).disposed(by: rx.disposeBag)
    }
    
    @IBAction func selectedElementsPressed(_ sender: Any) {
        
    }
    
}

extension ListContactsViewController: Bindable {
    
    func bind() {
        
        bindTableView()
        bindTitle()
        bindActivityIndicator()
        viewModel.getContacts.execute()
        viewModel.selectedElements.execute()
    }
}
