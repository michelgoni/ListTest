//
//  ListContactsViewController.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit
import RxSwift
import Action
import NSObject_Rx
import RxCocoa
import TransportsUI
import DomainLayer

public final class ListContactsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var data: Observable<[Contact]>?
    
    // MARK: ViewModel
    var viewModel: ContactsViewModel!
    let disposeBag = DisposeBag()
    
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
        
        data = Observable.merge(viewModel.getContacts.elements,
                                viewModel.updatedContacts.elements,
                                viewModel.searchContacts.elements,
                                viewModel.loadNextPageContacts.elements)
        
        data?.bind(to: tableView.rx.items(cellIdentifier: ContactsTableViewCell.identifier,
                                          cellType: ContactsTableViewCell.self)) { _, model, cell in
            cell.setup(with: model)
        } .disposed(by: rx.disposeBag)
    }
    
    private func bindPaginator() {
        self.tableView.rx
            .reachedBottom()
            .map { _ in () }
            .bind(to: viewModel.loadNextPageContacts.inputs)
            .disposed(by: rx.disposeBag)
    }
    
    private func bindSelectedData() {
        guard let data = data else {return}
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
    
    private func bindSearchBar() {
        
        searchBar.rx.text
            .orEmpty
            .filter{$0.count > 2}
            .asDriver(onErrorJustReturn: "")
            .throttle(.milliseconds(500))
            .drive(viewModel.searchContacts.inputs)
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
        }.asDriver(onErrorJustReturn: "")
        .drive( selectedButton.rx.title())
        .disposed(by: rx.disposeBag)
    }
    
    func bindButton() {
        
        let selected =  viewModel.updatedContacts.elements.flatMap { elements -> Observable<Bool> in
            return .just(!elements.filter({ $0.isSelected}).isEmpty)
        }.startWith(false)
        .asDriver(onErrorJustReturn: false)
        selected.drive(selectedButton.rx.isEnabled).disposed(by: rx.disposeBag)
        selected.drive {self.selectedButton.backgroundColor = $0 ? .primary : .primaryDisabled}
            .disposed(by: rx.disposeBag)
    }
    
    private func bindActivityIndicator() {
        
        Observable.merge(
            viewModel.getContacts.executing,
            viewModel.loadNextPageContacts.executing,
            viewModel.searchContacts.executing)
            .asDriver(onErrorJustReturn: true)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        
        Observable.merge(viewModel.getContacts.executing)
            .asDriver(onErrorJustReturn: true)
            .drive(tableView.rx.isHidden)
            .disposed(by: rx.disposeBag)
    }
    
    private func bindSelectButton() {
        
        viewModel.getContacts.executing
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: { [weak self] isLoading in
                self?.selectedButton.isEnabled = isLoading
                self?.selectedButton.backgroundColor = .primaryDisabled
                self?.selectedButton.setTitle("", for: .normal)
            }).disposed(by: rx.disposeBag)
    }
    
    private func bindButtonAction() {
        
        let contacts = viewModel.updatedContacts
            .elements
            .map{$0.filter{$0.isSelected}}
        
        selectedButton.rx.tap.withLatestFrom(contacts)
            .bind(to: viewModel.selectedContacts.inputs)
            .disposed(by: rx.disposeBag)
    }
    
    private func bindDismissSearchButton() {
        searchBar.searchTextField.clearButtonMode = .whileEditing
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { () in
                self.viewModel.getContacts.execute()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindErrors() {
        
        viewModel.getContacts.errors
            .asDriver(onErrorJustReturn: ActionError.underlyingError(DomainError.requestFailed))
            .drive { (error) in
                switch error {
                case .underlyingError(let undelyed):
                    if let casted = undelyed as? DomainError {
                        InfoView.showIn(viewController: self, message: casted.getError())
                    }
                    self.tableView.isHidden = true
                case .notEnabled:
                    break
                }
            }.disposed(by: rx.disposeBag)
    }
}

extension ListContactsViewController: Bindable {
    
    func bind() {
        
        bindTableView()
        bindSelectedData()
        bindSearchBar()
        bindTitle()
        bindButton()
        bindActivityIndicator()
        bindButtonAction()
        bindSelectButton()
        bindDismissSearchButton()
        viewModel.getContacts.execute()
        bindPaginator()
        bindErrors()
    }
}
