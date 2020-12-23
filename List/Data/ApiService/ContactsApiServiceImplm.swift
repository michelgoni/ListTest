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
       
       return  provider
            .request(
                ContactsService(baseUrl,
                                action: .getContacts(params: params,
                                                     paginatorParms: PaginatorParams(offset: 0, limit: 10)
                                )
                )
            ).mapApiError()


    }
    
    public func searchContacts(query: String) -> Single<SuperHeroResponse> {
        
      
        
//        let superHeroSearchRequest = SuperHeroSearchRequest(baseApiParams: BaseApiParams(date: Date(),
//                                                                                   publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
//                                                                                   privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93",
//                                                                                   offSet: 0,
//                                                                                   limit: 10),
//                                                      query: query)
//
//
//
//
        return Single.create { observer in

//            self.apiService.send(superHeroSearchRequest, success: { (success) in
//                observer(.success(success))
//            }) { (serverError) in
//                var error: ErrorResponse = ErrorResponse.generic()
//                if let clientError = serverError.clientError as? ErrorResponseContainer {
//                    error = clientError.error
//                } else if let rawError = serverError.rawError {
//                    error = ErrorResponse.generic(error: rawError)
//                }
//
//                observer(.error(error))
//            }


            return Disposables.create()
        }
        
    }
}
