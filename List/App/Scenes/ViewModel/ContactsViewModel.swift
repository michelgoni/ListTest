//
//  ContactsViewModel.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import Action
import RxCocoa

protocol ContactsViewModel {
    var contacts: Observable<[Contact]> { get }
    var selected: PublishSubject<Contact> { get }
    var selectedElementsIndex: BehaviorRelay<[Int]> { get }
}

class ContactsViewModelImplm: ContactsViewModel {
    var selectedElementsIndex = BehaviorRelay<[Int]>(value: [])
    
    let useCase: ContactsUseCase
    
    init(useCase: ContactsUseCase) {
        self.useCase = useCase
    }
    
    lazy var contacts: Observable<[Contact]> = {
        let elements: Observable<[Contact]>  = useCase.getContacts().mapResult()
        return Observable.merge(useCase.getContacts().mapResult(), Observable.combineLatest(elements, selectedElementsIndex) { names, selected in
            var mutable = names
            selected.forEach {mutable[$0].isSelected = true}
            return mutable
        })
    }()
    
    var selected = PublishSubject<Contact>()
    
}

