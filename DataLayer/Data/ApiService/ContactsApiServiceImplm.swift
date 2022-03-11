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

public class ContactsApiServiceImplm: ContactsApiService {
    
    private var params = BaseApiParams(date: Date(),
                                       publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                       privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93")
    
    public init(){}
    
    public func getSuperHeroContacts(offset: Int) -> Single<SuperHeroResponse> {
        let value = buildRequest(params: params,
                                  query: .getContacts(params: params, offset: offset))
            .map {
                try JSONDecoder().decode(SuperHeroResponse.self, from: $0)
            }.asSingle()
        return value
    }
    
    public func searchContacts(query: String) -> Single<SuperHeroResponse> {
        
        let value = buildRequest(params: params,
                                 query: .searchContacs(params: params,
                                                       query: query))
            .map {
                try JSONDecoder().decode(SuperHeroResponse.self, from: $0)
            }.asSingle()
        return value
    }
    
    private func buildRequest(params: BaseApiParams, query: Query) -> Observable<Data> {

        return URLSession.shared.rx.data(request: query.request)
    }
}

