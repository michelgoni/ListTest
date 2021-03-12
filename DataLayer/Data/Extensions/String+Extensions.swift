//
//  String+Extensions.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import CommonCrypto
import CryptoKit

extension String {
    var md5: String {
      let length = Int(CC_MD5_DIGEST_LENGTH)
      var digest = [UInt8](repeating: 0, count: length)
      if let data = data(using: String.Encoding.utf8) {
        _ = data.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
          CC_MD5(body, CC_LONG(data.count), &digest)
        }
      }

      return (0..<length).reduce("") {
        $0 + String(format: "%02x", digest[$1])
      }
    }
}
