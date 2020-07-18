//
//  ContactsApiServiceImplm.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import TransportationApiClient

public class ContactsApiServiceImplm: ContactsApiService {
    
    let apiService: APIClient
    
    public init(apiService: APIClient) {
        
        self.apiService = apiService
    }
    
    public func getSuperHeroContacts() -> Single<SuperHeroResponse> {
        let superHerorequest = SuperHeroRequest(baseApiParams: BaseApiParams(date: Date(),
                                                                             publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                                                             privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93"))
        return Single.create { [unowned self] observer in
            self.apiService.send(superHerorequest, success: { (success) in
                observer(.success(success))
            }) { (serverError) in
                var error: ErrorResponse = ErrorResponse.generic()
                if let clientError = serverError.clientError as? ErrorResponseContainer {
                    error = clientError.error
                } else if let rawError = serverError.rawError {
                    error = ErrorResponse.generic(error: rawError)
                }
                
                observer(.error(error))
            }
            return Disposables.create()
            
        }
    }
    
}
