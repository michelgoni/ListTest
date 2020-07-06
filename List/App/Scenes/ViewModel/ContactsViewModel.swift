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

protocol ContactsViewModel {
     var contacts: Action<Void, [Contact]> { get }
     var isSelected: Action<Contact, Contact> { get }
}

class ContactsViewModelImplm: ContactsViewModel {
    
    let useCase: ContactsUseCase
    
    init(useCase: ContactsUseCase) {
        self.useCase = useCase
    }
    
    lazy var contacts: Action<Void, [Contact]> = { this in
        Action<Void, [Contact]> { _ in
            return this.useCase.getContacts().mapResult()
        }
    }(self)
    
    lazy var isSelected: Action<Contact, Contact> = {this in
        
        Action<Contact, Contact> { contact in
            return .just(Contact(name: contact.name, image: contact.image, isSelected: !contact.isSelected))
        }
    }(self)
}

