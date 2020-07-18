//
//  SceneCoordinatorType.swift
//  List
//
//  Created by Miguel Goñi on 15/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    /// transition to another scene
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable
    
    /// pop scene from navigation stack or dismiss current modal
    @discardableResult
    func pop(animated: Bool) -> Completable
}

extension SceneCoordinatorType {
    @discardableResult
    func pop() -> Completable {
        return pop(animated: true)
    }
}


