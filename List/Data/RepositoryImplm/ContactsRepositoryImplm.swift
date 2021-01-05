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
    private var value =  [Contact]()
   
    public init(contactsApiService: ContactsApiService) {
        self.contactsApiService = contactsApiService
    }
    
    // MARK: -ContactsRepository
    public func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>> {
        
         contactsApiService
            .getSuperHeroContacts(offset: offset)
            .map {
                if offset == 10 {
                    self.value.append(contentsOf: $0.data.results.map(Contact.init))
                    return $0.data.results.map(Contact.init)
                }else {
                    self.value.append(contentsOf: $0.data.results.map(Contact.init))
                    return self.value
                }
            }
            .mapResponse()
    }
    
    public func searchContacts(query: String) -> Single<Result<[Contact], DomainError>> {
        
        contactsApiService.searchContacts(query: query)
            .map { $0.data.results.map(Contact.init)}
            .mapResponse()
    }
}
