//
//  Data+.swift
//  List
//
//  Created by Michel Goñi on 14/1/21.
//  Copyright © 2021 Miguel Goñi. All rights reserved.
//

import Foundation


extension Data {
    public func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
