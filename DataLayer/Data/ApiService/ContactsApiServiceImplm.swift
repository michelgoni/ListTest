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
    
    var params: BaseApiParams
    
    public init(params: BaseApiParams ){
        self.params = params
    }
    
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

