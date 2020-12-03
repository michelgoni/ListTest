//
//  ContactsService.swift
//  List
//
//  Created by Michel Goñi on 03/12/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import Moya

public enum ContactsServiceAction {
    
    case getSuperHeroContacts(offset: Int)
    case searchContacts(query: String)
}

public class ContactsService: MoyaService<ContactsServiceAction>{}

extension ContactsService: TargetType {
    
    public var baseURL: URL {
        switch action {
        case .getSuperHeroContacts:
            return URL(string: url)!
        case .searchContacts:
            return URL(string: url)!
        }
    }
}
