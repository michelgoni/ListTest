//
//  SceneCoordinator.swift
//  List
//
//  Created by Miguel Goñi on 15/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

open class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    private var window: UIWindow
    private var currentViewController: UIViewController
    
    required public init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController!
    }
    
    override public init() {
        self.window = UIWindow()
        self.window.backgroundColor = UIColor.white
        self.currentViewController = UIViewController()
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
      let subject = PublishSubject<Void>()
      let viewController = scene.viewController()
      switch type {
        case .root:
          currentViewController = SceneCoordinator.actualViewController(for: viewController)
          window.rootViewController = viewController
          subject.onCompleted()

        case .push:
          guard let navigationController = currentViewController.navigationController else {
            fatalError("Can't push a view controller without a current navigation controller")
          }
          // one-off subscription to be notified when push complete
          _ = navigationController.rx.delegate
            .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
            .map { _ in }
            .bind(to: subject)
          navigationController.pushViewController(viewController, animated: true)
          currentViewController = SceneCoordinator.actualViewController(for: viewController)

        case .modal:
          viewController.modalPresentationStyle = .fullScreen
          currentViewController.present(viewController, animated: true) {
            subject.onCompleted()
          }
          currentViewController = SceneCoordinator.actualViewController(for: viewController)
      }
      return subject.asObservable()
        .take(1)
        .ignoreElements()
    }
    
    @discardableResult
    public func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        if let presenter = currentViewController.presentingViewController {
            // dismiss a modal controller
            currentViewController.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
                subject.onCompleted()
            }
        } else if let navigationController = currentViewController.navigationController {
            // navigate up the stack
            // one-off subscription to be notified when pop complete
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
        return subject
            .take(1)
            .ignoreElements()
    }
}

extension SceneCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        currentViewController = viewController
    }
}
