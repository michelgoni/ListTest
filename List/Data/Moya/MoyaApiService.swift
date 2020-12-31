//
//  MoyaApiService.swift
//  List
//
//  Created by Michel Goñi on 20/12/20.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//


import Moya

public class MoyaApiService<Target: TargetType> {
    let baseUrl: String
    let provider: ListMoyaProvider<Target>
   

    public init(
        _ baseUrl: String,
        with provider: ListMoyaProvider<Target>) {
        self.baseUrl = baseUrl
        self.provider = provider
    }
}
