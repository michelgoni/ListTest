//
//  TextStyle.swift
//  TransportsUI
//
//  Created by Miguel Goñi on 30/05/2020.
//

import Foundation

public enum TextStyle: String, CaseIterable {
    case title1
    case title2
    case title3
    case button
    case headline
    case body
    case subheadline
    case footnote
    case caption1
    case caption2
    
    var textStyle: UIFont.TextStyle {
        switch self {
        case .title1:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .button:
            return .callout
        case .headline:
            return .headline
        case .body:
            return .body
        case .subheadline:
            return .subheadline
        case .footnote:
            return .footnote
        case .caption1:
            return .caption1
        case .caption2:
            return .caption2
        }
    }
}

