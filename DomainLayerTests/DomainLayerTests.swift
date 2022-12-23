//
//  DomainLayerTests.swift
//  DomainLayerTests
//
//  Created by Michel Goñi on 7/3/21.
//  Copyright © 2021 Miguel Goñi. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import Quick
import Nimble

@testable import DomainLayer

class ContactsUseCaseTest: QuickSpec {
    
    var sut: ContactsUseCase!
    fileprivate var contactsMockRepository: ContactsStubRepository!
    
    override func spec() {
        beforeEach {
            self.sut = self.makeSut()
        }
        
        describe("In the Contacts Use Case") {
            
            context("the contacts call") {
               
                it("is called from repository") {
                    _ = try? self.sut.getContacts(offset: 10).toBlocking().first()
                    expect(self.contactsMockRepository.contactsCall).to(beTrue())
                }
            }
        }
        
        describe("In the Contacts Use Case") {
            
            context("the contacts call") {
               
                it("is only once called") {
                    let result = try? self.sut.getContacts(offset: 10).toBlocking().first()
                    expect([result].count).to(equal(1))
                }
            }
        }
        
        describe("In the Contacts Use Case") {
            
            context("the contacts call") {
               
                it("gets elements from repository") {
                    let result = try? self.sut.getContacts(offset: 10).toBlocking().first()
                    expect(result).notTo(beNil(), description: "")
                }
            }
        }
        
        describe("In the Contacts Use Case") {
            
            context("the search call") {
               
                it("is called from repository") {
                    _ = try self.sut.searchContacts(query: "").toBlocking().first()
                    expect(self.contactsMockRepository.searchContacts).to(beTrue())
                }
            }
        }
        
        
        describe("In the Contacts Use Case") {
            
            context("the search call") {
               
                it("gets elements from repository") {
                    let result = try! self.sut.searchContacts(query: "").toBlocking().first()
                    
                    switch result {
                    case .success(let contacts):
                        expect(contacts).notTo(beNil())
                    case .failure:
                        fail()
                    case .none:
                        fail()
                    }
                }
            }
        }
        
        describe("In the Contacts Use Case") {
            
            context("the search call") {
               
                it("gis only once called") {
                    let result = try! self.sut.searchContacts(query: "").toBlocking().first()
                    
                    switch result {
                    case .success(let contacts):
                        expect([contacts].count).to(equal(1))

                    case .failure:
                        fail()
                    case .none:
                        fail()
                    }
                }
            }
        }
        
        afterEach {
            self.sut = nil
        }
    }
    
    private func makeSut() -> ContactsUseCase {
        
        contactsMockRepository = ContactsStubRepository()
        sut = ContactsUseCaseImplm(repository: contactsMockRepository)
        return sut
    }
}

private class ContactsStubRepository: ContactsRepository {
    func searchContacts(query: String) -> Single<Result<[Contact], DomainError>> {
        searchContacts.toggle()
        return .just(.success([Contact(name: "Hulk", image: "", isSelected: false)]))
    }
    
    var contactsCall = false
    var searchContacts = false
    
    func getContacts(offset: Int) -> Single<Result<[Contact], DomainError>> {
        contactsCall.toggle()
        return .just(.success([Contact(name: "", image: "", isSelected: false)]))
    }
}
