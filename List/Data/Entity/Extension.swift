//
//  Extension.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    
    func getExtension () -> String {
        switch self {
        case .gif:
            return "gif"
        case .jpg:
           return "jpg"
        }
    }
}

