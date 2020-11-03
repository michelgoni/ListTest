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
    private let limit = 10
    lazy var results: [Results] = {
        return [Results]()
    }()
    
    public init(apiService: APIClient) {
        
        self.apiService = apiService
    }

    
    public func getSuperHeroContacts(offset: Int) -> Single<[Results]> {
        
        let superHeroRequest = SuperHeroRequest(baseApiParams: BaseApiParams(
                                                    date: Date(),
                                                    publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                                    privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93",
                                                    offSet: offset,
                                                    limit: limit))
        
        return Single.create { [unowned self] observer in
            self.apiService.send(superHeroRequest, success: { (success) in
                
                if offset == 10 {
                    self.results.append(contentsOf: success.data.results)
                    observer(.success(success.data.results))
                } else {
                    self.results.append(contentsOf: success.data.results)
                    observer(.success(self.results))
                }

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
    
    public func searchContacts(query: String) -> Single<SuperHeroResponse> {
        
        let superHeroSearchRequest = SuperHeroSearchRequest(baseApiParams: BaseApiParams(date: Date(),
                                                                                   publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                                                                                   privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93",
                                                                                   offSet: 0,
                                                                                   limit: 10),
                                                      query: query)
        
        
        
        
        return Single.create { observer in
            
            self.apiService.send(superHeroSearchRequest, success: { (success) in
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
