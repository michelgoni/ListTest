//
//  ApiClient.swift
//  TransportationApiClient
//
//  Created by Miguel Goñi on 19/05/2020.
//

import Foundation
import Alamofire


open class APIClient {
    
    let sessionManager = Session()
    
    open var baseEndpoint: String {
        return ""
    }
    
    private let printsDebug: Bool
    
    public init(printsDebug: Bool = true) {
        self.printsDebug = printsDebug
    }
    
    open func send<T: APIRequest>(_ request: T, success: @escaping (T.Response) -> Void, failure: @escaping (ServerError) -> Void) {
        
        let endpoint = self.endpoint(for: request)
        let parameters = request.body
        let method = request.method
        
        let request = sessionManager.request(endpoint, method: method, parameters: parameters, encoding: JSONEncoding.default)
        
        if self.printsDebug {
            debugPrint(request)
        }
        
        request.responseJSON { response in
            if self.printsDebug {
                debugPrint(response)
            }
            if let data = response.data {
                let initialDecodeError: Error?
                do {
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    success(response)
                    return
                } catch {
                    initialDecodeError = error
                    // If we cant decode the response type, we try to decode the error type
                }
                
                do {
                    let response = try JSONDecoder().decode(T.Error.self, from: data)
                    let serverError = ServerError(rawError: nil, clientError: response)
                    failure(serverError)
                    return
                } catch {
                    let error = initialDecodeError ?? error
                    let serverError = ServerError(rawError: error, clientError: error)
                    failure(serverError)
                    return
                }
            } else if let error = response.error {
                let serverError = ServerError(rawError: error, clientError: nil)
                failure(serverError)
                return
            }
        }
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        let urlString = "\(baseEndpoint)\(request.resourceName)\(request.resourcePath)"
        return URL(string: urlString)!
    }
}



