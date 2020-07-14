//
//  ViewModel.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

protocol DetailContactsViewModel {
    var title: String { get }
}

struct DetailContacts: DetailContactsViewModel {
    
    var title: String
    
    init (title: String) {
        self.title = title
    }
}
