//
//  PrimitiveSequence+Extensions.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import DomainLayer

extension PrimitiveSequence where Trait == SingleTrait {
    
    public func mapResult<T>() -> Observable<T> {
        
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
    
    public func mapResponse() -> Single<Result<Element, DomainError>> {
        
        self.map { .success($0) }
            .catchError { error in
                if let apiError = error as? ApiError {
                    return .just(.failure(DomainError.customError(apiError.description)))
                } else {
                    return .just(.failure(.requestFailed))
                }
        }
    }
    
}


