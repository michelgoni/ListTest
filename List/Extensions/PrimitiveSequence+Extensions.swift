//
//  PrimitiveSequence+Extensions.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension PrimitiveSequence where Trait == SingleTrait {
    
    func mapResult<T>() -> Observable<T> {
        
        self.flatMap { result in
            
            switch result {
            case let result as Swift.Result<T, DomainError>:
                switch result {
                case .success(let value):
                    return .just(value)
                case .failure(let error):
                    return .error(error)
                }
            case let result as T:
                return .just(result)
            default:
                return .error(RxError.unknown)
            }
            
        }.asObservable()
        
    }
    
    func mapResponse() -> Single<Result<Element, DomainError>> {
        
        self.map { .success($0) }
            .catchError { error in
                if let apiError = error as? MoyaError {
                    guard let response = apiError.response else { return .just(.failure(DomainError.customError(apiError.localizedDescription))) }
                    do {
                        let value = try JSONDecoder().decode(ListError.self, from: response.data)
                        return .just(.failure(DomainError.customError(value.message)))
                    } catch {
                        return .just(.failure(DomainError.requestFailed))
                    }
                  
                }
                return .just(.failure(.requestFailed))
        }
    }
    
    
}
