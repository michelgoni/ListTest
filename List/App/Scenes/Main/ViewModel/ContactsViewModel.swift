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
    var selectedContacts: Action<Observable<[Contact]>, Void> { get }
    
}

public class ContactsViewModelImplm: ContactsViewModel {
    
    let useCase: ContactsUseCase
    let coordinator: SceneCoordinator
    
    public init(useCase: ContactsUseCase, coordinator: SceneCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
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
    
    lazy public var selectedContacts: Action<Observable<[Contact]>, Void> = { this in
        Action<Observable<[Contact]>, Void> { contacts in
            
            let detailContactsViewModel = DetailContacts(contacts: contacts, coordinator: this.coordinator)
            return this.coordinator.transition(to: .selectedContacts(detailContactsViewModel), type: .modal)
                .asObservable()
                .map {_ in}
        }
    }(self)
}
