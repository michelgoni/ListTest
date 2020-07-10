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

protocol ContactsViewModel {
    
    var getContacts: Action<Void, [Contact]> { get }
    var updatedNames: Action<(name: Contact, names: [Contact]), [Contact]> { get }
    var selectedElements: Action<Void,String> { get }
    
}

class ContactsViewModelImplm: ContactsViewModel {
   
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
            
            newContacts.append(contentsOf: value.names.map { $0.name == value.name.name ? Contact(name: value.name.name, image: value.name.image, isSelected: !$0.isSelected) : $0})
            return .just(newContacts)
        }
        
    }(self)
    
    lazy var selectedElements: Action<Void,String> = { this in
        
        Action<Void,String> {
            
            return  this.updatedNames.elements.flatMap { contacts -> Observable<String> in
                var value = ""
                switch contacts.filter({ $0.isSelected}).count {
                case 0:
                    value = ""
                case 1:
                    value = "\(contacts.filter{$0.isSelected}.count) elements selected"
                default:
                    value = "\(contacts.filter{$0.isSelected}.count) elements selected"
                }
                
                return .just(value)
            }
        }
    }(self)
}
