//
//  ContactsApiServiceImplm.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import Moya
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

public class ContactsApiServiceImplm: MoyaApiService<ContactsService>, ContactsApiService {
    
    private var params = BaseApiParams(date: Date(),
                                       publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                       privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93")


    
    public func getSuperHeroContacts(offset: Int) -> Single<SuperHeroResponse> {
        let value = buildRequest(offset: offset, pathComponent: "characters", params: params)
            .map {
            try JSONDecoder().decode(SuperHeroResponse.self, from: $0)
        }.asSingle()
        return value
    }
    
    public func searchContacts(query: String) -> Single<SuperHeroResponse> {
        
       return  provider
        .request(ContactsService(baseUrl,
                                 action: .searchContacts(params: params,
                                                         query: query)))
        .mapApiError()
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
