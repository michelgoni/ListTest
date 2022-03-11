//
//  ContactsRepositoryImplm.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import DomainLayer

public class ContactsRepositoryImplm: ContactsRepository {
    
    public let contactsApiService: ContactsApiService
    private var value =  [Contact]()
   
    public init(contactsApiService: ContactsApiService) {
        self.contactsApiService = contactsApiService
    }
    
    // MARK: -ContactsRepository
    public func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>> {
        
        return contactsApiService
            .getSuperHeroContacts(offset: offset)
            .map {
                self.value.append(contentsOf: $0.data.results.map(Contact.init))
                return self.value
            }.mapResponse()
    }
    
    public func searchContacts(query: String) -> Single<Result<[Contact], DomainError>> {
        
        contactsApiService.searchContacts(query: query)
            .map { $0.data.results.map(Contact.init)}
            .mapResponse()
    }
}
