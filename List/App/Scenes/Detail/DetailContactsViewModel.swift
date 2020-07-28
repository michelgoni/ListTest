//
//  ViewModel.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import Action

public protocol DetailContactsViewModel {
    var contacts: Observable<[Contact]> { get }
    var coordinator: SceneCoordinator { get }
    var dismiss: CocoaAction { get }
}

public class DetailContacts: DetailContactsViewModel {
    
    public var contacts: Observable<[Contact]>
    public var coordinator: SceneCoordinator
    
    public init (contacts: Observable<[Contact]>, coordinator: SceneCoordinator) {
        self.contacts = contacts
        self.coordinator = coordinator
    }
    
    lazy public var dismiss: CocoaAction = { this in
        CocoaAction { _ in
            this.coordinator.pop()
                .asObservable()
                .map{_ in}
        }
    }(self)
}
