//
//  Environment.swift
//  List
//
//  Created by Miguel Goñi on 11/3/22.
//  Copyright © 2022 Miguel Goñi. All rights reserved.
//

import Foundation

enum Environment {
    enum Plist {
        static let apiKey = "API_KEY"
        static let privateKey = "PRIVATE_KEY"
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Plist.apiKey] as? String else {
            fatalError("The Marvel Api Key is not set in the plist for this environment")
        }
        return apiKey
    }()
    
    static let privateKey: String = {
        guard let privateKey = Environment.infoDictionary[Plist.privateKey] as? String else {
            fatalError("The Marvel Private Key is not set in the plist for this environment")
        }
        return privateKey
    }()
    
}
