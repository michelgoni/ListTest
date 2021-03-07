//
//  ApiErrorTest.swift
//  ListTests
//
//  Created by Michel Goñi on 14/1/21.
//  Copyright © 2021 Miguel Goñi. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import Quick
import Nimble
import DomainLayer
@testable import List

class ApiErrorTest: QuickSpec {
    
    override func spec() {
        
        describe("Api error test implementation") {
           
            var sut: DomainError!
            var moyaError: Data!
            
            beforeEach {
                moyaError = """
                               {"code":"InvalidCredentials","message":"That hash, timestamp and key combination is invalid."}
                               """.data(using: .utf8)!
            }
            it("uses decodable properly") {
                
                let listError = try moyaError.decoded() as ListError
                expect(listError.code) == "InvalidCredentials"
            }
            
          
            it("fails with a custom error") {
               
                let listError = try moyaError.decoded() as ListError
                sut = DomainError.customError(listError.message)
                switch sut {
                case .customError(let text):
                    expect(text) == "That hash, timestamp and key combination is invalid."
                default: fail()
                }
            }
            
            it("fails with request fail") {
                sut = DomainError.requestFailed
                switch sut {
                case .requestFailed: assert(true)
                default: fail()
                }
            }
            
            it("fails with unknown failure") {
                sut = DomainError.unknown
                switch sut {
                case .unknown: assert(true)
                default: fail()
                }
            }
        }
        
        
    }
    
}
