//
//  ApiError.swift
//  List
//
//  Created by Michel Goñi on 03/12/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import DomainLayer

public enum ApiError: Error {
    case requestFailed
 
}

extension ApiError {
    public var domainError: DomainError {
        switch self {
        case .requestFailed:
            return .requestFailed
        
        }
    }
}
