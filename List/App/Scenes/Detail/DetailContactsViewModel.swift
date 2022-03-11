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
import NSObject_Rx
import RxCocoa
import DomainLayer

public protocol DetailContactsViewModel {
    var contacts: [Contact] { get }
    var coordinator: SceneCoordinator { get }
    var resetContacts: CocoaAction { get }
    var dismiss: CocoaAction { get }
}

public class DetailContacts: DetailContactsViewModel {
    
    public var contacts: [Contact]
    public var coordinator: SceneCoordinator
    public var resetContacts: CocoaAction
    let disposeBag = DisposeBag()
    
    public init (contacts: [Contact], coordinator: SceneCoordinator, resetContacts: CocoaAction) {
        self.contacts = contacts
        self.coordinator = coordinator
        self.resetContacts = resetContacts
        
        resetContacts.executionObservables
            .take(1)
            .subscribe(onNext: { _ in
                coordinator.pop()
            }).disposed(by: disposeBag)
    }
    
    lazy public var dismiss: CocoaAction = { [unowned self] in
        CocoaAction { _ in
            
            self.coordinator.pop()
                .asObservable()
                .map{_ in}
        }
    }()
}
