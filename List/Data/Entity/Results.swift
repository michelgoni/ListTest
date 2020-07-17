//
//  Results.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public struct Results: Codable {
    public let id: Int
    public let name: String
    public let thumbnail: Thumbnail
}

public extension Contact {
    
    init(contact: Results) {
        self.init(name: contact.name,
                  image: contact.thumbnail.imageUrl,
                  isSelected:false)
    }
}
