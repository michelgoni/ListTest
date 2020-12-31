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


public protocol ContactsViewModel {
    
    var getContacts: Action<Void, [Contact]> { get }
    var loadNextPageContacts: Action<Void, [Contact]> { get }
    var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> { get }
    var selectedContacts: Action<[Contact], Void> { get }
    var resetContacts: CocoaAction { get }
    var searchContacts: Action<String, [Contact]> { get }
    
    var offset: Int { get set}
}

public class ContactsViewModelImplm: ContactsViewModel {
    
    let useCase: ContactsUseCase
    let coordinator: SceneCoordinator
    public var offset: Int = 10
    
    public init(useCase: ContactsUseCase, coordinator: SceneCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    lazy public var getContacts: Action<Void, [Contact]> = { this in
        Action <Void, [Contact]> {

            return this.useCase
                .getContacts(offset: self.offset)
                .mapResult()
        }
    }(self)
    
    lazy public var loadNextPageContacts: Action<Void, [Contact]> = { this in
        Action <Void, [Contact]> {
            self.offset += 10
            return this.useCase
                .getContacts(offset: self.offset)
                .mapResult()
        }
    }(self)
    
    lazy public var resetContacts: CocoaAction = { this in
        CocoaAction { _ in
             this.getContacts.execute()
                .asObservable()
                .map{ _ in}
        }
    }(self)
    
    lazy public var updatedContacts: Action<(contact: Contact, contacts: [Contact]), [Contact]> = { _ in
        
        Action<(contact: Contact, contacts: [Contact]), [Contact]> { value in
            var newContacts = [Contact]()
            
            newContacts.append(contentsOf: value.contacts.map { $0.name == value.contact.name ? Contact(name: value.contact.name, image: value.contact.image, isSelected: !$0.isSelected) : $0})
            
            return .just(newContacts)
        }
        
    }(self)
    
    lazy public var selectedContacts: Action<[Contact], Void> = {  this in
        Action<[Contact], Void> { contacts in
            
            let detailContactsViewModel = DetailContacts(
                contacts: contacts,
                coordinator: this.coordinator,
                resetContacts: self.resetContacts)
            
            return this.coordinator
                .transition(to: .selectedContacts(detailContactsViewModel), type: .modal)
                .asObservable()
                .map {_ in}
        }
    }(self)
    
    
    lazy public var searchContacts: Action<String, [Contact]> = { this in
        
        Action<String, [Contact]> { query in
            
            this.useCase
                .searchContacts(query: query)
                .mapResult()
           
        }
    }(self)
}
