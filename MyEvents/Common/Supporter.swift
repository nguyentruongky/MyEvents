//
//  Supporter.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/6/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

struct meSupporter {
    
    static func makeTextField(placeholder: String) -> UITextField {
        
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = .black
        tf.placeholder = placeholder
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        
        let underline = UIView()
        underline.tag = 101
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = UIColor.color(value: 141)
        
        tf.addSubview(underline)
        underline.horizontal(toView: tf)
        underline.bottom(toView: tf)
        underline.height(0.5)
        
        return tf
    }
}
