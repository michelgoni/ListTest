//
//  MoyaService.swift
//  List
//
//  Created by Michel Goñi on 03/12/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation

public class MoyaService<Action> {
    let url: String
    let action: Action

    init(_ url: String,  action: Action) {
        self.url = url
        self.action = action
    }
}

