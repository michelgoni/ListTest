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

public struct BaseApiParams {
    let date: Date
    let publicApiKey: String
    let privateKey: String
    let offSet: Int
    let limit: Int
    
    var timeStamp: String {
        guard let date = date.toMillis() else {
            return ""
        }
        return "\(date)"
    }
    
    var hash: String   {
        return "\(privateKey)\(publicApiKey)".md5
       }
  
}

