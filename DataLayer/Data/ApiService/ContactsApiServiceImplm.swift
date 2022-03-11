//
//  ContactsApiServiceImplm.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContactsAPiService2 {
    
    private var baseParams = BaseApiParams(date: Date(),
                                           publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                           privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93")
    
    func getSuperHeroContacts(offset: Int) -> Single<SuperHeroResponse> {
        let value = buildRequest(offset: offset, pathComponent: "characters", params: baseParams).map { data in
            try JSONDecoder().decode(SuperHeroResponse.self, from: data)
        }.asSingle()
        return value
        
    }
    
    private func buildRequest(offset: Int, pathComponent: String, params: BaseApiParams) -> Observable<Data> {
        let baseurl = URL(string: "http://gateway.marvel.com/v1/public")
        let url = baseurl!.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "apikey", value: params.publicApiKey)
        let hash = URLQueryItem(name: "hash", value: params.hash)
        let timeStamp = URLQueryItem(name: "ts", value: params.timeStamp)
        let offset = URLQueryItem(name: "offset", value: String(offset))
        let limit = URLQueryItem(name: "limit", value: String(10))
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        var queryItems = [URLQueryItem]()
        queryItems.append(contentsOf: [keyQueryItem, hash, offset, timeStamp, limit])
        urlComponents.queryItems = queryItems
        request.url = urlComponents.url!
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        return session.rx.data(request: request)
    }
    
    
}

public class ContactsApiServiceImplm: ContactsApiService {
    
    private var params = BaseApiParams(date: Date(),
                                       publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                       privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93")
    
    public init(){}
    
    public func getSuperHeroContacts(offset: Int) -> Single<SuperHeroResponse> {
        let value = buildRequest( pathComponent: "characters", params: params, query: .getContacts(params: params, offset: offset))
            .map {
                try JSONDecoder().decode(SuperHeroResponse.self, from: $0)
            }.asSingle()
        return value
    }
    
    public func searchContacts(query: String) -> Single<SuperHeroResponse> {
        
        let value = buildRequest(pathComponent: "characters",
                                 params: params,
                                 query: .searchContacs(params: params,
                                                       query: query))
            .map {
                try JSONDecoder().decode(SuperHeroResponse.self, from: $0)
            }.asSingle()
        return value
    }
    
    private func buildRequest( pathComponent: String, params: BaseApiParams, query: Query) -> Observable<Data> {
        let baseurl = URL(string: "http://gateway.marvel.com/v1/public")
        let url = baseurl!.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        urlComponents.queryItems = query.queryItems
        request.url = urlComponents.url!
        request.httpMethod = "GET"
        return URLSession.shared.rx.data(request: request)
    }
}

enum Query {
    
    case getContacts(params: BaseApiParams, offset: Int)
    case searchContacs(params: BaseApiParams, query: String)
    
    var queryItems:  [URLQueryItem] {
        switch self {
        case .getContacts(params: let params, offset: let offset):
            let keyQueryItem = URLQueryItem(name: "apikey", value: params.publicApiKey)
            let hash = URLQueryItem(name: "hash", value: params.hash)
            let timeStamp = URLQueryItem(name: "ts", value: params.timeStamp)
            let limit = URLQueryItem(name: "limit", value: String(10))
            let offset = URLQueryItem(name: "offset", value: String(offset))
            return [keyQueryItem, hash, timeStamp, limit, offset]
            
        case .searchContacs(params: let params, query: let query):
            let query = URLQueryItem(name: "name", value: query)
            let timeStamp = URLQueryItem(name: "ts", value: params.timeStamp)
            let keyQueryItem = URLQueryItem(name: "apikey", value: params.publicApiKey)
            let hash = URLQueryItem(name: "hash", value: params.hash)
            return [query, timeStamp, keyQueryItem, hash]
        }
    }
}
