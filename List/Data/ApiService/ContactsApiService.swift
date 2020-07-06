//
//  ContactsApiService.swift
//  List
//
//  Created by Miguel Goñi on 21/06/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift

 protocol ContactsApiService {
    func getSuperHeroContacts() -> Single<SuperHeroResponse>
}