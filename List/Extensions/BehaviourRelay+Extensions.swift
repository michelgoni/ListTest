//
//  BehaviourRelay+Extensions.swift
//  List
//
//  Created by Miguel Goñi on 06/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func add(element: Element.Element) {
        
        var array = self.value
        array.append(element)
        self.accept(array)
    }
    
    func remove(at index: Element.Index) {
        var newValue = value
        let finalIndex = value.firstIndex { $0 as? Element.Index == index} ?? 0 as! Element.Index
        newValue.remove(at: finalIndex)
        accept(newValue)
    }
}
