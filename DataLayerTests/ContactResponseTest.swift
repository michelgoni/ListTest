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
    
    var sut: (contactsResponse: SuperHeroResponse, contactResponse: SuperHeroResponse)!
    
    override func spec() {
        
        beforeEach {
            self.sut = self.makeSut()
        }
        
        describe("The Contacts Response element") {
            context("when the api call has a 200 response") {
                it("contains Data and Results inside contactResponse") {
                    expect(self.sut.contactResponse.data).notTo(beNil())
                    expect(self.sut.contactResponse.data.results).notTo(beNil())
                }
            }
        }
        
        describe("The Contacts Response element") {
            context("when the api call has a 200 response") {
                it("maps properly from SuperHeroResponse to Contacts class") {
                    let contacts = self.sut.contactsResponse.data.results.map(Contact.init)
                    expect(contacts).notTo(beNil())
                }
            }
        }
        
        describe("The Contacts Response element") {
            context("When the api call has a 200 response") {
                
                it("has expected data") {
                    let contact = self.sut.contactsResponse.data.results.map(Contact.init).first!
                    expect(contact.name).to(be("3-D Man"))
                    expect(contact.isSelected).to(beFalse())
                }
            }
        }
        
        describe("The Contacts Response element") {
            context("when the api serves a malformatted json file") {
                
                it("doesn´t decode a not valid Json file") {
                    let json = """
                                   {
                                       "ddfd": "1.0"
                                   }
                                   """.data(using: .utf8)!
                     let sut = try? JSONDecoder().decode(SuperHeroResponse.self, from: json)

                    expect(sut?.data).to(beNil())
                    expect(sut?.data.results).to(beNil())
                }
            }
        }
        
        describe("The Contacts Response element") {
            context("when the api called has a 200 response, the transformed response") {
                
                it("should work with equatable") {
                    let contact1 = Observable.of(self.sut.contactsResponse.data.results.map(Contact.init).first!)
                    let contact2 = Observable.of(self.sut.contactResponse.data.results.map(Contact.init).first!)
                    _ = Observable.combineLatest(contact1, contact2) {expect($0 == $1).to(beTrue())}
                }
            }
        }
        
        describe("The Contacts Response element") {
            context("when the api called has a 200 response") {
                
                it("gets image path properly") {
                    let fakeImagePath = "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"
                    expect(self.sut.contactsResponse.data.results.first!.thumbnail.imageUrl) == fakeImagePath
                }
            }
        }
     
        describe("The Contacts Response element") {
            context("when the api called has a 200 response") {
                
                it("gets thumbnail extension properly") {
                    let thumbnailExtension = self.sut.contactsResponse.data.results.first!.thumbnail.thumbnailExtension.getExtension()
                    expect(thumbnailExtension).to(be("jpg"))
                }
            }
        }
        
        afterEach {
            self.sut = nil
        }
    }
    
    private func makeSut() -> (contactsResponse: SuperHeroResponse, contactResponse: SuperHeroResponse) {
        
        let contactsResponse: SuperHeroResponse! = self.read(file: "contacts")
        let contactResponse: SuperHeroResponse! = self.read(file: "contact")
        return (contactsResponse, contactResponse)
    }
}
