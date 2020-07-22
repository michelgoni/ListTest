//
//  ViewModel.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

public protocol DetailContactsViewModel {
    var contacts: Observable<[Contact]> { get }
}

public struct DetailContacts: DetailContactsViewModel {
    
    public var contacts: Observable<[Contact]>
    
    public init (contacts: Observable<[Contact]>) {
        self.contacts = contacts
    }
}
