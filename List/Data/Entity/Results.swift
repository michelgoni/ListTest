//
//  Results.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

struct Results: Codable {
    let id: Int
    let name: String
    let thumbnail: Thumbnail
}

extension Contact {
    
    init(contact: Results) {
        self.init(name: contact.name,
                  image: contact.thumbnail.imageUrl,
                  isSelected:false)
    }
}
