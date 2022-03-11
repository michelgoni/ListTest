//
//  ContactsApiServiceRequest.swift
//  DataLayer
//
//  Created by Miguel Goñi on 11/3/22.
//  Copyright © 2022 Miguel Goñi. All rights reserved.
//

import Foundation

enum Query {
    
    case getContacts(params: BaseApiParams, offset: Int)
    case searchContacs(params: BaseApiParams, query: String)
    
    var baseUrl: String {
        switch self {
        case .getContacts, .searchContacs:
            return "http://gateway.marvel.com/v1/public"
        }
    }
    
    var pathComponent: String {
        switch self {
        case .getContacts, .searchContacs:
            return "characters"
        }
    }
    
    var requestMethod: String {
        switch self {
        case .getContacts, .searchContacs:
            return "GET"
        }
    }
    
    var url: URL {
        switch self {
        case .getContacts, .searchContacs:
            let baseurl = URL(staticString: baseUrl)
            let url = baseurl.appendingPathComponent(pathComponent)
            return url
        }
    }
    
    var commonUrlQueryItems: [URLQueryItem] {
        switch self {
        case .getContacts(let params, _), .searchContacs(let params, _):
            let keyApikey = URLQueryItem(name: "apikey", value: params.publicApiKey)
            let keyHash = URLQueryItem(name: "hash", value: params.hash)
            let keyTimeStamp = URLQueryItem(name: "ts", value: params.timeStamp)
            return [keyApikey, keyHash, keyTimeStamp]
        
        }
    }
    
    var  request: URLRequest {
        switch self {
        case .getContacts(_, let offset):
            var request = URLRequest(url: url)
            guard let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else {
                fatalError("Could not make urlComponents")
            }
            let keyLimit = URLQueryItem(name: "limit", value: String(10))
            let keyOffset = URLQueryItem(name: "offset", value: String(offset))
            var queryItems: [URLQueryItem] = [ keyLimit, keyOffset]
            queryItems.append(contentsOf: commonUrlQueryItems)
            urlComponents.queryItems = queryItems
            request.url = urlComponents.url!
            request.httpMethod = requestMethod
            return request
            
        case .searchContacs(_, let query):
            var request = URLRequest(url: url)
            guard let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else {
                fatalError("Could not make urlComponents")
            }
            let query = URLQueryItem(name: "name", value: query)
            var queryItems: [URLQueryItem] = [query]
            queryItems.append(contentsOf: commonUrlQueryItems)
            urlComponents.queryItems = queryItems
            request.url = urlComponents.url!
            request.httpMethod = requestMethod
            return request
        }
    }
}
