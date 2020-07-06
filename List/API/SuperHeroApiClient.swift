//
//  SuperHeroApiClient.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import TransportationApiClient

public class SuperHeroApiClient: APIClient {
    
    static let shared = SuperHeroApiClient( printsDebug: true)
    
    override public var baseEndpoint: String {
        return "http://gateway.marvel.com"
    }
    
    public func sendServer<T: APIRequest>(_ request: T, success: @escaping (T.Response) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        send(request, success: success) { (serverError: ServerError) in
            var error: ErrorResponse = ErrorResponse.generic()
            if let clientError = serverError.clientError as? ErrorResponseContainer {
                error = clientError.error
            } else if let rawError = serverError.rawError {
                error = ErrorResponse.generic(error: rawError)
            }
            failure(error)
        }
    }
    
}
