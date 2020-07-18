//
//  Scene.swift
//  List
//
//  Created by Miguel Goñi on 14/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public enum Scene {
    case contacts(ContactsViewModel)
    case selectedContacts(DetailContactsViewModel)
}
