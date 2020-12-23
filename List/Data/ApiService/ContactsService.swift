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
    case getContacts(params: BaseApiParams, paginatorParms: PaginatorParams)
    case searchContacts(params: BaseApiParams, query: String)
}

extension ContactsService: TargetType {
    
    //MARK:-- Base url
    public var baseURL: URL {
        switch action {
        case .getContacts, .searchContacts:
            return URL(string: url + "/v1/public")!
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
        case .getContacts:
            return
                "characters"
//                "ts&=\(params.timeStamp)&apikey=\(params.publicApiKey)&hash=\(params.hash)&offset=\(String(paginatorParams.offset))&limit=\(String(paginatorParams.limit))"
            
        case .searchContacts(let params, let query):
           return "name=\(query)&ts&=\(params.timeStamp)&apikey=\(params.publicApiKey)&hash=\(params.hash)"
        }
    }
    
    public var task: Task {
        switch action {
        case .getContacts(let params, let paginatorParams):
            return .requestParameters(parameters: ["ts": params.timeStamp, "apikey": params.publicApiKey, "hash": params.hash], encoding: URLEncoding.default)
        case .searchContacts:
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
