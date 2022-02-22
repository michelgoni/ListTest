//
//  DataLayerTests.swift
//  DataLayerTests
//
//  Created by Michel Goñi on 12/3/21.
//  Copyright © 2021 Miguel Goñi. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import Quick
import Nimble
import DomainLayer
@testable import DataLayer

class ContactsRepositoryTest: QuickSpec {
    var sut: ContactsRepository!
    fileprivate var contactsApiServiceSpy: ContactsApiServiceSpy!
    
    override func spec() {
        super.spec()
        beforeEach {
            self.sut = self.makeSut()
        }
        
        describe("The implementation of contactRepository") {
            context("when gets contacts") {
                it("gives service an OK response") {
                    let response: SuperHeroResponse = self.read(file: "contacts")!
                    self.contactsApiServiceSpy.contactsResponse = response
                    let result = try! self.sut.getContacts(offset: 10).toBlocking().first()
                    
                    switch result {
                    case .success(let contacts):
                        expect(contacts).notTo(beNil())
                    default:
                        fail()
                    }
                }
            }
        }
        
        describe("The implementation of contactRepository") {
            context("when it gets contacts") {
                it("is only once called") {
                    let response: SuperHeroResponse = self.read(file: "contacts")!
                    self.contactsApiServiceSpy.contactsResponse = response
                    let result = try! self.sut.getContacts(offset: 10).toBlocking().first()
                    
                    switch result {
                    case .success(let contacts):
                        expect([contacts].count).to(be(1))
                    default:
                        fail()
                    }
                }
            }
        }
        
        describe("The implementation of contactRepository") {
            context("when it gets an server error response") {
                it("gives service a KO response") {
                    let response: SuperHeroResponse = self.read(file: "contacts")!
                    self.contactsApiServiceSpy.contactsResponse = response
                    self.contactsApiServiceSpy.badResponse = true
                    let result = try! self.sut.getContacts(offset: 10).toBlocking().first()
                    
                    switch result {
                    case .failure(let error):
                        expect(error).to(beAKindOf(DomainError.self))
                    default:
                        fail()
                    }
                }
            }
        }
        
        describe("The implementation of contactRepository") {
            context("when it doesn´t get any contacts") {
                it("gets and empty response") {
                    let response: SuperHeroResponse = self.read(file: "emptyResponse")!
                    self.contactsApiServiceSpy.contactsResponse = response
                    let result = try! self.sut.getContacts(offset: 10).toBlocking().first()
                    
                    switch result {
                    case .success(let contacts):
                        expect(contacts.isEmpty).to(beTrue())
                    default:
                        fail()
                    }
                }
            }
        }
        
        describe("The implementation of contactRepository") {
            context("When it makes a search call") {
                it("it gives an ok result") {
                    let response: SuperHeroResponse = self.read(file: "searchResults")!
                    self.contactsApiServiceSpy.contactsResponse = response
                    
                    let result = try! self.sut.searchContacts(query: "").toBlocking().first()
                    
                    do {
                        let value = try result?.get()
                        expect(value).notTo(beNil())
                    } catch {
                        fail()
                    }
                }
            }
        }
        
        afterEach {
            self.sut = nil
        }
    }
    
    private func makeSut() -> ContactsRepository {
        contactsApiServiceSpy = ContactsApiServiceSpy()
        sut = ContactsRepositoryImplm(contactsApiService: contactsApiServiceSpy)
        return sut
    }
}


private class ContactsApiServiceSpy: ContactsApiService {
   
    var contactsResponse: SuperHeroResponse!
    var badResponse = false
    
    // MARK: - ContactsApiService protocol
    func getSuperHeroContacts(offset: Int) -> Single<SuperHeroResponse>  {
        
        if badResponse {
            return .error(ApiError.requestFailed)
        }
        return .just(contactsResponse)
    }
    
    func searchContacts(query: String) -> Single<SuperHeroResponse> {
        return .just(contactsResponse)
    }
}
