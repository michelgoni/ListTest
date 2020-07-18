//
//  ContactsRepositoryTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 18/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import Quick
import Nimble
import List

class ContactsRepositoryTest: QuickSpec {
    
    override func spec() {
        describe("Implementation of contactRespository") {
            
            var sut: ContactsRepositoryImplm!
            var contactsApiServiceMock: ContactsApiServiceMock!
            
            beforeEach {
                contactsApiServiceMock = ContactsApiServiceMock()
                sut = ContactsRepositoryImplm(contactsApiService: contactsApiServiceMock)
            }
            
            describe("Getting contacts") {
                
                it("Gives service an OK response") {
                    let response: SuperHeroResponse = self.read(file: "contacts")!
                    contactsApiServiceMock.contactsResponse = response
                    let result = try! sut.getContacts().toBlocking().first()
                    
                    switch result {
                    case .success(let contacts):
                        expect(contacts).notTo(beNil())
                    default:
                        fail()
                        
                    }
                }
                
                it("Gives service a KO response") {
                    let response: SuperHeroResponse = self.read(file: "contacts")!
                    contactsApiServiceMock.contactsResponse = response
                    contactsApiServiceMock.badResponse = true
                    let result = try! sut.getContacts().toBlocking().first()
                    
                    switch result {
                    case .failure(let error):
                        expect(error).to(beAKindOf(ErrorResponse.self))
                    default:
                        fail()
                    }
                }
                
            }
            
        }
        
        
    }
    
    
    class ContactsApiServiceMock: ContactsApiService {
        
        
        var contactsResponse: SuperHeroResponse!
        var badResponse = false
        
        
        // MARK: - ContactsApiService protocol
        func getSuperHeroContacts() -> Single<SuperHeroResponse> {
            
            if badResponse {
                return .error(ErrorResponse.generic())
            }
            return .just(contactsResponse)
        }
        
    }
}