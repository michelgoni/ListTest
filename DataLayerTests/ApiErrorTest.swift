//
//  ApiErrorTest.swift
//  ListTests
//
//  Created by Michel Goñi on 14/1/21.
//  Copyright © 2021 Miguel Goñi. All rights reserved.
//

import XCTest
import Quick
import Nimble
import DomainLayer
@testable import List

class ApiErrorTest: QuickSpec {
    
    var sut: DomainError!
    var moyaError: Data!
    
    override func spec() {
        
        beforeEach {
//            self.moyaError = self.makeMoyaError()
        }
        
//        describe("The Api implementation") {
//            context("when receives a Moya error") {
//                it(" decodes it properly") {
//
//                    let listError = try self.moyaError.decoded() as ListError
//                    expect(listError.code) == "InvalidCredentials"
//                }
//            }
//        }
//
//        describe("The Api implementation") {
//            context("when receives a Moya error") {
//                it("decodes it properly in a Domain error") {
//
//                    let listError: ListError = try self.moyaError.decoded()
//                    expect(listError).to(beAKindOf(ListError.self))
//                }
//            }
//        }
        
//        describe("The Api implementation") {
//            context("when receives a custom error") {
//                it("fails with a proper custom error and message") {
//                   
//                    let listError = try self.moyaError.decoded() as ListError
//                    self.sut = DomainError.customError(listError.message)
//                    switch self.sut {
//                    case .customError(let text):
//                        expect(text) == "That hash, timestamp and key combination is invalid."
//                    default: fail()
//                    }
//                }
//            }
//        }
//        
        describe("The Api implementation") {
            context("when the request fails") {
                it("fails with request fail error") {
                    self.sut = DomainError.requestFailed
                    switch self.sut {
                    case .requestFailed:
                        assert(true)
                    default: fail()
                    }
                }
            }
        }
        
        describe("The Api implementation") {
            context("when the request fails with a 500 server error") {
                it("fails with unknown failure") {
                    self.sut = DomainError.unknown
                    switch self.sut {
                    case .unknown: assert(true)
                    default: fail()
                    }
                }
            }
        }
        
        afterEach {
            self.sut = nil
        }
    }
    
    private func makeSut(_ error: DomainError) -> DomainError{
        
        switch error {
        case .requestFailed:
            return .requestFailed
        case .customError(let errorMessage):
            return .customError(errorMessage)
        case .unknown:
            return .unknown
        }
        
    }
    
//    private func makeMoyaError() -> Data {
//                                          """
//                                          {"code":"InvalidCredentials","message":"That hash, timestamp and key combination is invalid."}
//                                          """.data(using: .utf8)!
//    }
    
}
