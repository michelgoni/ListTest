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
        
       
        
        let data = viewModel.contacts.elements
        
        data.bind(to:
            tableView.rx.items(
                cellIdentifier: ContactsTableViewCell.identifier,
                cellType: ContactsTableViewCell.self)
        ) { _, model, cell in
            cell.setup(with: model)
        }
        .disposed(by: bag)
        
       
        
//        let newData = Observable.combineLatest(tableView.rx.itemSelected, elementsSubject).map { indexPath, elements in
//
//            elements.enumerated().map { index, value in
//
//                return Contact(name: value.name, image: value.image, isSelected: index == indexPath.row)
//            }
//        }
//        tableView.rx.modelSelected(Contact.self).bind(to: viewModel.isSelected.inputs).disposed(by: bag)
//
//      
//
//        tableView.rx.itemSelected
//                   .map { $0.row }
//                   .distinctUntilChanged()
//                   .bind(to: selectedItemSubject)
//                   .disposed(by: bag)

    
    }
}

extension ListContactsViewController: Bindable {
    
    func bind() {
        
        bindTableView()
        viewModel.contacts.execute()
    }
}
    
