//
//  BaseApiParams.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import CommonCrypto
import CryptoKit

public class BaseApiParams {
    let date: Date
    let publicApiKey: String
    let privateKey: String
    
    public init(date: Date,publicApiKey: String, privateKey: String ) {
        self.date = date
        self.publicApiKey = publicApiKey
        self.privateKey = privateKey
    }
    
    var timeStamp: String {
        guard let date = date.toMillis() else {
            return ""
        }
        return "\(date.description)"
    }
    
    var hash: String   {
        return "\(timeStamp)\(privateKey)\(publicApiKey)".md5
    }
}

