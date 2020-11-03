//
//  SuperHeroRequest.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import Alamofire
import TransportationApiClient

struct SuperHeroRequest: APIRequest {
    typealias Response = SuperHeroResponse
    typealias Error = ErrorResponseContainer
    
    public var resourceName: String {
        return "/v1/public/characters?"
    }
    
    public var method: HTTPMethod {
        return HTTPMethod.get
    }
    
    public var resourcePath: String {
        return "ts&=\(baseApiParams.timeStamp)&apikey=\(baseApiParams.publicApiKey)&hash=\(baseApiParams.hash)&offset=\(String(baseApiParams.offSet))&limit=\(String(baseApiParams.limit))"
    }
    
    public var body: Parameters? {
        return nil
    }
    
    let baseApiParams: BaseApiParams
    
    var adapter: RequestAdapter?
    
    public init(baseApiParams: BaseApiParams) {
        self.baseApiParams = baseApiParams
    }
}
