//
//  ContactsFake.swift
//  ListTests
//
//  Created by Miguel Goñi on 19/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
@testable import List

struct ContactsFake {
    
    static let contactSelected = Contact(name: "3d-Man", image: "", isSelected: true)
    
    static let contacts = [Contact(name: "3d-Man", image: "", isSelected: false),
                           Contact(name: "SuperMan", image: "", isSelected: false)]
    
    static let contactsSelected = [Contact(name: "3d-Man", image: "", isSelected: true),
                                   Contact(name: "SuperMan", image: "", isSelected: false)]
}
