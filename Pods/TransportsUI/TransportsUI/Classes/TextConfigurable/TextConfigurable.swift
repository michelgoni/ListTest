//
//  TextConfigurable.swift
//  TransportsUI
//
//  Created by Miguel Goñi on 27/05/2020.
//

import UIKit


public protocol TextConfigurableProtocol {
    var text: String { get set }
    var font: UIFont { get set }
    var color: UIColor { get set }
    var alignment: NSTextAlignment { get set }
}

public struct TextConfigurable: TextConfigurableProtocol {
    public var text: String
    public var font: UIFont
    public var color: UIColor
    public var alignment: NSTextAlignment
    
    public init(text: String, font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
        
    }
}
