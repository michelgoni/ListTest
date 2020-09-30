//
//  ContactsRepository.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

public protocol ContactsRepository {
    
    func getContacts() -> Single<Result<[Contact], ErrorResponse>>
     func searchContacts(query: String) -> Single<Result<[Contact], ErrorResponse>>
}

