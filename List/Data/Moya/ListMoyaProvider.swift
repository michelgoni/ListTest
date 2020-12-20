//
//  ListMoyaProvider.swift
//  List
//
//  Created by Michel Goñi on 20/12/20.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public class ListMoyaProvider<Target: TargetType>: MoyaProvider<Target> {
    
    private let baseParams: BaseApiParams
    
    public init ( baseParams: BaseApiParams) {
        self.baseParams = baseParams
       
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(configuration:
                                    NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            )
        ]
        super.init(plugins: plugins)
    }
}
