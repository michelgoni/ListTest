//
//  ListSectionModel.swift
//  List
//
//  Created by Michel Goñi on 7/3/21.
//  Copyright © 2021 Miguel Goñi. All rights reserved.
//

import Foundation
import RxDataSources
import DomainLayer

public struct SectionOfCustomData {
    public var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    
    public typealias Item = Contact
    public init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
