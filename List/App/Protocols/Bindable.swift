//
//  Bindable.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import UIKit

protocol Bindable {
  associatedtype ViewModelType
  var viewModel: ViewModelType! { get set }
  func bind()
}

extension Bindable where Self: UIViewController {
  mutating func bind(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bind()
  }
}

