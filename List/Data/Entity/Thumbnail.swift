//
//  Thumbnail.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    var imageUrl: String {
        return path + "." + thumbnailExtension.getExtension()
    }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
