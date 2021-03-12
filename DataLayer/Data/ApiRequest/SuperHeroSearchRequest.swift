//
//  SuperheroSearchRequest.swift
//  List
//
//  Created by Michel Goñi on 16/10/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import Alamofire
import TransportationApiClient

struct SuperHeroSearchRequest: APIRequest {

    typealias Response = SuperHeroResponse
    typealias Error = ErrorResponseContainer
    
    public var resourceName: String {
        return "/v1/public/characters?"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    public var resourcePath: String {
        return "name=\(query)&ts&=\(baseApiParams.timeStamp)&apikey=\(baseApiParams.publicApiKey)&hash=\(baseApiParams.hash)"
    }
    
    public var body: Parameters? {
        return nil
    }
    
    let baseApiParams: BaseApiParams
    let query: String
    
    var adapter: RequestAdapter?
    
    public init(baseApiParams: BaseApiParams,
                query: String) {
        self.baseApiParams = baseApiParams
        self.query = query
    }

}
