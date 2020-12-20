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

public class ContactsService: MoyaService<ContactsAction>{}

public enum ContactsAction {
    case getContacts(params: BaseApiParams)
    case searchContacts(params: BaseApiParams)
}

extension ContactsService: TargetType {
    
    //MARK:-- Base url
    public var baseURL: URL {
        switch action {
        case .getContacts, .searchContacts:
            return URL(string: url + "/v1/public/characters?")!
        }
    }
    
    //MARK:-- Method
    public var method: Moya.Method {
        switch action {
        case .getContacts, .searchContacts:
            return .get
        }
    }
    
    //MARK:-- Path
    public var path: String {
        switch action {
        case .getContacts(let params), .searchContacts(let params):
            return "ts&=\(params.timeStamp)&apikey=\(params.publicApiKey)&hash=\(params.hash)&offset=\(String(params.offSet))&limit=\(String(params.limit))"
        }
    }
    
    public var task: Task {
        switch action {
        case .getContacts, .searchContacts:
            return .requestPlain
        
        }
    }
    
    public var sampleData: Data {
        return Data.init()
    }
    public var headers: [String: String]? {
        return ["Content-Type": "application/json; charset=utf8"]
    }
}
