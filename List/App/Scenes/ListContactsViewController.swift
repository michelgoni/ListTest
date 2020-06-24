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
    

    
    // MARK: Dispose Bag
    private let bag = DisposeBag()
    
    // MARK: ViewModel
    var viewModel: ContactsViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindTableView()
        viewModel.contacts.execute()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let data = Observable<[String]>.just(["first element", "second element", "third element"])
//
//        data.bind(to: tableView.rx.items(cellIdentifier: ContactsTableViewCell.identifier)) { index, model, cell in
//          cell.textLabel?.text = model
//        }
//        .disposed(by: bag)
    }
    
    
    // MARK: - Private
    private func setupTableView() {
        let contactCellNib = UINib(nibName: ContactsTableViewCell.nibName, bundle:nil)
        tableView.register(contactCellNib, forCellReuseIdentifier: ContactsTableViewCell.identifier)
         tableView.estimatedSectionFooterHeight = 50
        
        
    }
    
    private func bindTableView() {
            
            
            let data = viewModel.contacts.elements
            
            data.bind(onNext: {
                print($0)
                
            }).disposed(by: bag)
         
            
            data.bind(to:
                tableView.rx.items(
                    cellIdentifier: ContactsTableViewCell.identifier,
                    cellType: ContactsTableViewCell.self)
            ) { _, model, cell in
                cell.setup(with: model)
            }
            .disposed(by: bag)

            
        }
    
    
}


extension ListContactsViewController: Bindable {
    
    func bind() {
       
        
   
    }
    
    
    
    
}


