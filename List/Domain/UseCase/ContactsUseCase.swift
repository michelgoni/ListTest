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
    
    func getContacts() -> Single<Result<[Contact], ErrorResponse>>
    func searchContacts(query: String) -> Single<Result<[Contact], ErrorResponse>>
}

public class ContactsUseCaseImplm: ContactsUseCase {
    
    private let repository: ContactsRepository
    
    public init (repository: ContactsRepository) {
        self.repository = repository
    }
    
    public func getContacts() -> Single<Result<[Contact], ErrorResponse>> {
        repository.getContacts()
    }
    
    public func searchContacts(query: String) -> Single<Result<[Contact], ErrorResponse>> {
        repository.searchContacts(query: query)
    }
}
