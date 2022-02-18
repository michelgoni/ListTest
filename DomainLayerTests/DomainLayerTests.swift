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

    override func spec() {
        describe("Contacts UseCase implementation test") {
            var sut: ContactsUseCaseImplm!
            var contactsMockRepository: ContactsMockRepository!
            
            beforeEach {
                
                contactsMockRepository = ContactsMockRepository()
                sut = ContactsUseCaseImplm(repository: contactsMockRepository)
            }
            
            it("gets Contacts call from repository") {
                _ = try? sut.getContacts(offset: 10).toBlocking().first()
                expect(contactsMockRepository.contactsCall).to(beTrue())
            }
            
            it("gets Contacts elements from repository") {
                let result = try? sut.getContacts(offset: 10).toBlocking().first()
                expect(result).notTo(beNil(), description: "")
            }
            it("gets contacts search call from repository") {
                 _ = try sut.searchContacts(query: "").toBlocking().first()
                expect(contactsMockRepository.searchContacts).to(beTrue())
            }
            
            it("gets contacts search result from repository") {
                let result = try! sut.searchContacts(query: "").toBlocking().first()
                
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
}

private  class ContactsMockRepository: ContactsRepository {
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
