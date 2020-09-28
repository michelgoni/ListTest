//
//  ContactsUseCaseTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
import List
import RxSwift
import RxBlocking
import Quick
import Nimble

class ContactsUseCaseTest: QuickSpec {

    override func spec() {
        describe("Contacts UseCase implementation test") {
            var sut: ContactsUseCaseImplm!
            var contactsMockRepository: ContactsMockRepository!
            
            beforeEach {
                
                contactsMockRepository = ContactsMockRepository()
                sut = ContactsUseCaseImplm(repository: contactsMockRepository)
            }
            
            it("gets Contacts call from respository") {
                _ = try? sut.getContacts().toBlocking().first()
                expect(contactsMockRepository.contactsCall).to(beTrue())
            }
            
            it("gets Contacts elements from respository") {
                let result = try? sut.getContacts().toBlocking().first()
                expect(result).notTo(beNil(), description: "")
            }
        }
    }
    
    
    class ContactsMockRepository: ContactsRepository {
        func searchContacts(query: String) -> Single<Result<[Contact], ErrorResponse>> {
            return .just(.success([Contact(name: "", image: "", isSelected: false)]))
        }
        
        
        var contactsCall = false
        
        func getContacts() -> Single<Result<[Contact], ErrorResponse>> {
            contactsCall.toggle()
            return .just(.success([Contact(name: "", image: "", isSelected: false)]))
        }
        
        
    }

}
