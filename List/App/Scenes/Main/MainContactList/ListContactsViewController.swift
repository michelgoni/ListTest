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
import TransportsUI

 public class ListContactsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedButton: UIButton!
    
    // MARK: ViewModel
    var viewModel: ContactsViewModel!
    
    public override func viewDidLoad() {
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
        
        let data = Observable.merge(viewModel.getContacts.elements, viewModel.updatedContacts.elements)
        
        
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
            .map {(contact: $1, contacts: $0)}
        
        tableView
            .rx
            .itemSelected
            .withLatestFrom(combinedData)
            .bind(to: viewModel.updatedContacts.inputs)
            .disposed(by: rx.disposeBag)
        
        
    }
    
    private func bindTitle() {

        var value = ""
        viewModel.updatedContacts.elements.flatMap { contacts -> Observable<String> in
            switch contacts.filter({ $0.isSelected}).count {
            case 0:
                value = ""
            case 1:
                value = "\(contacts.filter{$0.isSelected}.count) element selected"
            default:
                value = "\(contacts.filter{$0.isSelected}.count) elements selected"
            }
            
            return .just(value)
        }.bind(to: selectedButton.rx.title()).disposed(by: rx.disposeBag)
    }
    
    
    func bindButton() {
       let selected =  viewModel.updatedContacts
            .elements
            .withLatestFrom(viewModel.updatedContacts.elements)
            .flatMap { elements -> Observable<Bool> in
                return .just(!elements.filter({ $0.isSelected}).isEmpty)
        }.startWith(false)
            
        selected.subscribe(onNext: { [weak self] (selected) in
            self?.selectedButton.isEnabled = selected
            self?.selectedButton.backgroundColor = selected ? .primary : .primaryDisabled
        }).disposed(by: rx.disposeBag)
        
    }
    
    private func bindActivityIndicator() {
                
        Observable.merge(viewModel.getContacts.executing)
            .subscribe(onNext: { [weak self] isLoading in
            isLoading ? self?.showLoading() : self?.hideLoading()
        }).disposed(by: rx.disposeBag)
    }
    
    @IBAction func selectedElementsPressed(_ sender: UIButton) {
        
        selectedButton
            .rx.tap.subscribe(onNext: {[weak self] _ in
                
                if let contacts = self?.viewModel.updatedContacts.elements.map({ $0.filter{$0.isSelected}}) {
                    self?.viewModel.selectedContacts.inputs.onNext(contacts)
                }
            }).disposed(by: rx.disposeBag)
        
        //let selectedContactsViewModel = DetailContacts(contacts: <#T##[Contact]#>)
    }
    
}

extension ListContactsViewController: Bindable {
    
    func bind() {
        
        bindTableView()
        bindTitle()
        bindButton()
        bindActivityIndicator()
        viewModel.getContacts.execute()
        
    }
}
