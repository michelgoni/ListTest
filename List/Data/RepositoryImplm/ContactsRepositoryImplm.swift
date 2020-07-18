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
   public func getContacts() -> Single<Result<[Contact], ErrorResponse>> {
        
        return self.contactsApiService
            .getSuperHeroContacts()
            .map { $0.data.results.map(Contact.init)}
            .mapResponse()
    }
}
