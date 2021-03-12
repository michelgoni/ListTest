//
//  ContactResponseTest.swift
//  ListTests
//
//  Created by Miguel Goñi on 17/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import XCTest
import List
import RxSwift
import Quick
import Nimble
import DomainLayer
import DataLayer

class ContactResponseTest: QuickSpec {

    override func spec() {
        
        describe("Test for Contacts response") {
            var contactsResponse: SuperHeroResponse!
            var contactResponse: SuperHeroResponse!
            
            beforeEach {
                contactsResponse = self.read(file: "contacts")
                contactResponse = self.read(file: "contact")
            }
            
            it("Maps from response to Contacts class is working") {
                let contacts = contactsResponse.data.results.map(Contact.init)
                expect(contacts).notTo(beNil())
            }
            
            it("Contains Data and Results inside contactResponse") {
                expect(contactResponse.data).notTo(beNil())
                expect(contactResponse.data.results).notTo(beNil())
            }
            
            it("Decodable is properly working") {
                let contact = contactsResponse.data.results.map(Contact.init).first!
                expect(contact.name).to(be("3-D Man"))
                expect(contact.isSelected).to(beFalse())
            }
            
            it("Decodable doesn´t decode not valid Json file") {
                let json = """
                               {
                                   "ddfd": "1.0"
                               }
                               """.data(using: .utf8)!
                 let sut = try? JSONDecoder().decode(SuperHeroResponse.self, from: json)
                
                expect(sut?.data).to(beNil())
                expect(sut?.data.results).to(beNil())
            }
            
            it("Equatable is properly working") {
                let contact1 = Observable.of(contactsResponse.data.results.map(Contact.init).first!)
                let contact2 = Observable.of(contactResponse.data.results.map(Contact.init).first!)
                _ = Observable.combineLatest(contact1, contact2) {expect($0 == $1).to(beTrue())}
                
            }
            
            it("Gets image path properly") {
                let fakeImagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"
                expect(contactsResponse.data.results.first!.thumbnail.imageUrl) == fakeImagePath
            }
            
            it("Gets thumbnail extension properly") {
                let thumbnailExtension = contactsResponse.data.results.first!.thumbnail.thumbnailExtension.getExtension()
                expect(thumbnailExtension).to(be("jpg"))
                
            }
        }
    }

}
