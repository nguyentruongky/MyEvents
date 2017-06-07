//
//  Font+Color.swift
//  Marco
//
//  Created by Ky Nguyen on 6/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


enum marFont: String {

    case muli_Black = "Muli-Black"
    case muli_Bold = "Muli-Bold"
    case muli_ExtraBold = "Muli-ExtraBold"
    case muli_ExtraLight = "Muli-ExtraLight"
    case muli_Light = "Muli-Light"
    case muli_Regular = "Muli-Regular"
    case muli_SemiBold = "Muli-SemiBold"
    case openSans_Bold = "OpenSans-Bold"
    case openSans_ExtraBold = "OpenSans-ExtraBold"
    case openSans_Light = "OpenSans-Light"
    case openSans_Regular = "OpenSans-Regular"
    case openSans_Semibold = "OpenSans-Semibold"
    
    static func font(name: marFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name.rawValue, size: size) else { return UIFont.boldSystemFont(ofSize: size) }
        return font
    }
    
    
}



struct marColor {
    
    static let mar_182_152_90_gold = UIColor.color(r: 182, g: 152, b: 90)
    static let mar_74 = UIColor.color(value: 74)
}

