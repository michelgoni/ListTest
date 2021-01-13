//
//  Moya+.swift
//  List
//
//  Created by Michel Goñi on 20/12/20.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Moya
import RxSwift

extension Reactive where Base: MoyaProviderType {}

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapApiError<D: Decodable>() -> Single<D> {
        
        self.map(D.self)
            .catchError { error in
                if let apiError = error as? MoyaError {
                    
                    return .error(apiError)
                }
                return .error(ApiError.requestFailed)
            }
    }
    
    
}

 struct NetworkingError: Error {

    let httpResponse: HTTPURLResponse?
    let networkData: Data?
    let baseError: MoyaError

    init(_ response:Response) {
        self.baseError = MoyaError.statusCode(response)
        self.httpResponse = response.response
        self.networkData = response.data
    }

    func getLocalizedDescription() -> String {

       return self.baseError.localizedDescription
    }
}

struct ListError: Codable {
    var code: String
    var message: String
}
