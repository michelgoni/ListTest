//
//  ViewModel.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public protocol DetailContactsViewModel {
    var contacts: [Contact] { get }
}

public struct DetailContacts: DetailContactsViewModel {
    
    public var contacts: [Contact]
    
    init (contacts: [Contact]) {
        self.contacts = contacts
    }
}
