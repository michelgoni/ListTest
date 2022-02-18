//
//  XCTestCase+.swift
//  ListTests
//
//  Created by Miguel Goñi on 17/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest

extension XCTestCase {
    func read<T: Decodable>(file: String) -> T? {
        let testBundle = Bundle(for: type(of: self))
        guard let file = testBundle.url(forResource: file, withExtension: "json"),
            let data = try? Data(contentsOf: file) else {
                return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

