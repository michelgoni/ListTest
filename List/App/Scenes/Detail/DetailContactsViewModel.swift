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

public protocol DetailContactsViewModel {
    var contacts: Observable<[Contact]> { get }
    var coordinator: SceneCoordinator { get }
    var resetContacts: CocoaAction { get }
    var dismiss: CocoaAction { get }
}

public class DetailContacts: DetailContactsViewModel {
    
    public var contacts: Observable<[Contact]>
    public var coordinator: SceneCoordinator
    public var resetContacts: CocoaAction
    let disposeBag = DisposeBag()
    
    public init (contacts: Observable<[Contact]>, coordinator: SceneCoordinator, resetContacts: CocoaAction) {
        self.contacts = contacts
        self.coordinator = coordinator
        self.resetContacts = resetContacts
        
        resetContacts.executionObservables
            .take(1)
            .subscribe(onNext: { _ in
                coordinator.pop()
            }).disposed(by: disposeBag)
    }
    
    lazy public var dismiss: CocoaAction = { this in
        CocoaAction { _ in
            
            this.coordinator.pop()
                .asObservable()
                .map{_ in}
        }
    }(self)
    
    
    

}
