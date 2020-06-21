//
//  Contact.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public struct Contact {
    
    var name: String
    var image: String
    var isSelected: Bool
    
    public init(name: String, image: String, isSelected: Bool) {
        self.name = name
        self.image = image
        self.isSelected = isSelected
    }
}

