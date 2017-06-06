//
//  UIExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    func changeTitleColor(_ color: UIColor = UIColor.blue, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        let deleteCardFormat = [
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: font]
        setTitleTextAttributes(deleteCardFormat, for: UIControlState())
    }
}


extension UILabel{
    func createSpaceBetweenLines(_ alignText: NSTextAlignment = NSTextAlignment.left, spacing: CGFloat = 7) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.maximumLineHeight = 40
        paragraphStyle.alignment = .left
        
        let ats = [NSParagraphStyleAttributeName:paragraphStyle]
        attributedText = NSAttributedString(string: self.text!, attributes:ats)
        textAlignment = alignText
    }
}


