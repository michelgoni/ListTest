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
    var coordinator: SceneCoordinator { get }
}

public struct DetailContacts: DetailContactsViewModel {
    
    public var contacts: Observable<[Contact]>
    public var coordinator: SceneCoordinator
    
    public init (contacts: Observable<[Contact]>, coordinator: SceneCoordinator) {
        self.contacts = contacts
        self.coordinator = coordinator
    }
}
