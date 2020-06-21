//
//  ContactsRepositoryImplm.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

class ContactsRepositoryImplm: ContactsRepository {
    
    let contactsApiService: ContactsApiService
    
    init(contactsApiService: ContactsApiService) {
        self.contactsApiService = contactsApiService
    }
    
    // MARK: -ContactsRepository
    func getContacts() -> Single<Result<[Contact], ErrorResponse>> {
        
        return self.contactsApiService
            .getSuperHeroContacts()
            .map { $0.data.results.map(Contact.init)}
            .mapResponse()
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    
    func mapResponse() -> Single<Result<Element, ErrorResponse>> {
        
        self.map { .success($0) }
            .catchError { error in
                if let apiError = error as? ErrorResponse {
                    return .just(.failure(apiError))
                }
                return .just(.failure(ErrorResponse.generic()))
            }
    }
}
