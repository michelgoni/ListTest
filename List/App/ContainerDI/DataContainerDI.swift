//
//  DataContainerDI.swift
//  List
//
//  Created by Michel Goñi on 20/12/20.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import DataLayer

class DataContainerDI {

    static let shared = DataContainerDI()
    
    private var baseApiParms: BaseApiParams {
        return BaseApiParams(date: Date(),
                             publicApiKey: Environment.apiKey,
                             privateKey: Environment.privateKey)
    }
    
    lazy var contacts: ContactsApiService = {
        return ContactsApiServiceImplm(params: baseApiParms)
    }()
}
