//
//  Thumbnail.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public struct Thumbnail: Codable {
   public let path: String
   public let thumbnailExtension: Extension
    
    public var imageUrl: String {
        return path + "." + thumbnailExtension.getExtension()
    }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
