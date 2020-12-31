//
//  DataContainerDI.swift
//  List
//
//  Created by Michel Goñi on 20/12/20.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

class DataContainerDI {

    static let shared = DataContainerDI()
    
    private static var baseUrl: String {
        "http://gateway.marvel.com"
    }

    private var baseApiParms: BaseApiParams {
        return BaseApiParams(date: Date(),
                             publicApiKey: "ab96482ca6c6b9304f381e5ac433ce59",
                             privateKey: "95b8baf2f2882d5ead42665c539b60d2b9741e93")
    }
    
    lazy var contacts: ContactsApiService = {
        return ContactsApiServiceImplm(DataContainerDI.baseUrl,
                                       with: ListMoyaProvider())
    }()

}
