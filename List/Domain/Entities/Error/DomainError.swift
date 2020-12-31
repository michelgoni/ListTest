//
//  DomainError.swift
//  List
//
//  Created by Michel Goñi on 03/12/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public enum DomainError: Error {
   
    case requestFailed
    case customError(_ text: String)
    case unknown
}
