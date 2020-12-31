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


public class ContactsApiServiceImplm: MoyaApiService<ContactsService>, ContactsApiService {
    
    private var params = BaseApiParams(date: Date(),
                                       publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                       privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93")


    
    public func getSuperHeroContacts(offset: Int) -> Single<SuperHeroResponse> {
       
         provider
            .request(
                ContactsService(baseUrl,
                                action: .getContacts(params: params,
                                                     paginatorParms: PaginatorParams(offset: offset,
                                                                                     limit: 10)))
            ).mapApiError()
    }
    
    public func searchContacts(query: String) -> Single<SuperHeroResponse> {
        
       return  provider
        .request(ContactsService(baseUrl,
                                 action: .searchContacts(params: params,
                                                         query: query)))
        .mapApiError()
    }
}
