//
//  ApiRequest.swift
//  TransportationApiClient
//
//  Created by Miguel Goñi on 19/05/2020.
//

import Foundation
import Alamofire

/// All requests must conform to this protocol
/// - Discussion: You must conform to Encodable too, so that all stored public parameters
///   of types conforming this protocol will be encoded as parameters.
public protocol APIRequest {
    
    associatedtype Response: Decodable
    associatedtype Error: Decodable

    // Endpoint for this request (the last part of the URL)
    var resourceName: String { get }
    
    //HTTP Method
    var method: HTTPMethod { get }
    
    //Parameters to be appended in url
    var resourcePath: String { get }
    
    //Body of the parameter
    var body: Parameters? { get }
    
    //Adapter
    var adapter: RequestAdapter? { get }
}


