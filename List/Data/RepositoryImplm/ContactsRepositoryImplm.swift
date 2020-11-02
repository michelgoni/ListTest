//
//  ContactsRepositoryImplm.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

public class ContactsRepositoryImplm: ContactsRepository {
    
    
    public let contactsApiService: ContactsApiService
   
    
    public init(contactsApiService: ContactsApiService) {
        self.contactsApiService = contactsApiService
    }
    
    // MARK: -ContactsRepository
    public func getContacts(offset: Int) -> Single<Result<[Contact], ErrorResponse>> {
        
        return self.contactsApiService
            .getSuperHeroContacts(offset: offset)
            .map { $0.map(Contact.init)}
            .mapResponse()
    }
    
    public func searchContacts(query: String) -> Single<Result<[Contact], ErrorResponse>> {
        
        return self.contactsApiService.searchContacts(query: query)
            .map { $0.data.results.map(Contact.init)}
            .mapResponse()
    }
}
