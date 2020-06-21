//
//  FontStyles.swift
//  TransportsUI
//
//  Created by Miguel Goñi on 30/05/2020.
//

import Foundation

public let fontStyle: FontStyleProtocol = FontStyle()

public protocol FontStyleProtocol {
    func font(forTextStyle textStyle: TextStyle) -> UIFont
}


public final class FontStyle: FontStyleProtocol {
    
    static let fontPlistFileName = "FontStyle"
    
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }
    
    private typealias StyleDictionary = [UIFont.TextStyle.RawValue: FontDescription]
    private var styleDictionary: StyleDictionary?
    
    fileprivate init() {
        if let url = Bundle.main.url(forResource: FontStyle.fontPlistFileName, withExtension: "plist"),
            let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            if let customStyle = try? decoder.decode(StyleDictionary.self, from: data) {
                styleDictionary = customStyle
            }
        }
    }
    
    public func font(forTextStyle fontTextSyle: TextStyle) -> UIFont {
        guard let fontDescription = styleDictionary?[fontTextSyle.textStyle.rawValue],
            let font = UIFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
                debugPrint("Font not found for: \(fontTextSyle.textStyle.rawValue)")
                return UIFont.preferredFont(forTextStyle: fontTextSyle.textStyle)
        }
        
        if #available(iOS 11.0, *) {
            return UIFontMetrics(forTextStyle: fontTextSyle.textStyle).scaledFont(for: font)
        } else {
            return font
        }
    }
}
