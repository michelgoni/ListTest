//
//  ErrorResponseContainer.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public struct ErrorResponseContainer: Decodable {
    public let error: ErrorResponse
}

public struct ErrorResponse: Decodable, Error {
   
    let internalMessage: String
    
    public static func generic(error: Error? = nil) -> ErrorResponse {
        return ErrorResponse(internalMessage: error?.localizedDescription ?? "Unknown error")
    }
    
   public var errorString: String {
        return "\(internalMessage)"
    }
}

