//
//  ColorTheme.swift
//  Pods-TransportsUI_Example
//
//  Created by Miguel Goñi on 16/07/2020.
//

import Foundation

import UIKit

public enum ColorThemePalette: String, CaseIterable {
    case background
    case dark
    case disabled
    case error
    case information
    case light
    case primary
    case secondary
    case success
    case textDark
    case textLight
    case warning
    
    public var color: UIColor {
        return UIColor.init(named: self.rawValue) ?? .white
    }
    
    public var highlighted: UIColor {
        return UIColor.init(named: self.rawValue + "Highlighted") ?? UIColor.init(named: self.rawValue) ?? .white
    }
    
    public var disabled: UIColor {
        return UIColor.init(named: self.rawValue + "Disabled") ?? UIColor.init(named: self.rawValue) ?? .white
    }
}
