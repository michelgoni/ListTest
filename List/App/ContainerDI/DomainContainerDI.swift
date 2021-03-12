//
//  DomainContainerDI.swift
//  List
//
//  Created by Michel Goñi on 20/12/20.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import DomainLayer
import DataLayer

class DomainContainerDI {
    
    static let shared = DomainContainerDI()
    
    lazy var contactsRepository: ContactsRepository = {
        return ContactsRepositoryImplm(contactsApiService: DataContainerDI.shared.contacts)
    }()
    
    lazy var contactsUseCase: ContactsUseCase = {
       return ContactsUseCaseImplm(repository: contactsRepository)
    }()
}
