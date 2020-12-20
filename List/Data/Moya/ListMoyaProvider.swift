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
    

    public init ( ) {
        
       
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(configuration:
                                    NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            )
        ]
        super.init(plugins: plugins)
    }
    
    func request(_ target: Target) -> Single<Response> {
        return self.rx.request(target, callbackQueue: nil)
    }
}
