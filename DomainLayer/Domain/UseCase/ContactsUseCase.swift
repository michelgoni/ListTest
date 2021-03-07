//
//  ContactsUseCase.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

public protocol ContactsUseCase {
    
    func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>>
    func searchContacts(query: String) -> Single<Result<[Contact], DomainError>>
}

public class ContactsUseCaseImplm: ContactsUseCase {
    
    private let repository: ContactsRepository
    
    public init (repository: ContactsRepository) {
        self.repository = repository
    }
    
    public func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>> {
         repository.getContacts(offset: offset)
    }
    
    public func searchContacts(query: String) -> Single<Result<[Contact], DomainError>> {
        repository.searchContacts(query: query)
    }
}
