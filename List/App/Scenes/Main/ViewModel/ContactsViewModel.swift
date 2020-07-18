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
import NSObject_Rx

public protocol ContactsViewModel {
    
    var getContacts: Action<Void, [Contact]> { get }
    var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> { get }
    var selectedContacts: Action<[Contact], Swift.Never> { get }
    
    
}

public class ContactsViewModelImplm: ContactsViewModel {
   
    let useCase: ContactsUseCase
    
   public init(useCase: ContactsUseCase) {
        self.useCase = useCase
    }
    
    lazy public var getContacts: Action<Void, [Contact]> = { this in
        Action <Void, [Contact]> {
            this.useCase.getContacts().mapResult()
        }
    }(self)
    
    lazy public var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> = { _ in
        
        Action<(contact: Contact, contacts: [Contact]), [Contact]> { value in
            var newContacts = [Contact]()
            
            newContacts.append(contentsOf: value.contacts.map { $0.name == value.contact.name ? Contact(name: value.contact.name, image: value.contact.image, isSelected: !$0.isSelected) : $0})
            return .just(newContacts)
        }
        
    }(self)
    
    
    lazy public var selectedContacts: Action<[Contact], Never> = { this in
        Action<[Contact], Never> { contacts in
            
           
            
            return .empty()
        }
    }(self)
}
