//
//  Supporter.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/6/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

struct meSupporter {

    static func makeActionButton(title: String, backgroundColor: UIColor = UIColor.color(value: 141)) -> UIButton {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)

        button.setBackgroundColor(color: backgroundColor, forState: .normal)
        button.setBackgroundColor(color: backgroundColor.withAlphaComponent(0.5), forState: .disabled)

        button.createRoundCorner(22)
        return button

    }

    static func makeUnderlineTextField(placeholder: String) -> UITextField {
        
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

    static func makeFloatTextField(placeholder: String) -> FloatLabelTextField {

        let tf = FloatLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = UIColor.color(value: 74)
        tf.placeholder = placeholder
        return tf
    }
}
