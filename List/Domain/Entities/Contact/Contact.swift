//
//  Contact.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

 protocol ContactRepresentable {
    var name: String {get}
    var image: String {get}
    var isSelected: Bool {get}
}

public struct Contact: ContactRepresentable, Equatable {
    
    var name: String
    var image: String
    var isSelected: Bool
    
    public init(name: String, image: String, isSelected: Bool) {
        self.name = name
        self.image = image
        self.isSelected = isSelected
    }
    
    public static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name
    }
}

