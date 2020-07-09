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
    
    var getContacts: Action<Void, [Contact]> { get }
    var updatedNames: Action<(name: Contact, names: [Contact]), [Contact]> { get }
    
}

class ContactsViewModelImplm: ContactsViewModel {
    var selectedElementsIndex = BehaviorRelay<[Int]>(value: [])
    
    let useCase: ContactsUseCase
    
    init(useCase: ContactsUseCase) {
        self.useCase = useCase
    }
    
    lazy var getContacts: Action<Void, [Contact]> = { this in
        Action <Void, [Contact]> {
            this.useCase.getContacts().mapResult()
        }
    }(self)
    
    lazy var updatedNames: Action<(name: Contact, names: [Contact]), [Contact]> = { _ in
        
        Action<(name: Contact, names: [Contact]), [Contact]> { value in
            var newContacts = [Contact]()
            
            let _ = value.names.reduce([]) {value.name == $1 ? newContacts.append(Contact(name: value.name.name, image: value.name.image, isSelected: !$1.isSelected)) : newContacts.append($1)
                
                return newContacts
            }
            
            return .just(newContacts)
        }
        
    }(self)
}

