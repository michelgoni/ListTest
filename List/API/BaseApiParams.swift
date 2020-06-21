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

struct BaseApiParams {
    let date: Date
    let publicApiKey: String
    let privateKey: String
    
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

