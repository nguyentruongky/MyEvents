//
//  ForgotPassword.swift
//  meco
//
//  Created by Ky Nguyen on 6/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


class meForgotPasswordController: knController {
    
    var output : meForgotPasswordControllerOutput?
    
    var email: String? {
        didSet {
            emailTextField.text = email
        }
    }
    
    let emailTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = .white
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.tintColor = .white
        
        let underline = UIView()
        underline.tag = 101
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = .white
        
        tf.addSubview(underline)
        underline.horizontal(toView: tf)
        underline.bottom(toView: tf)
        underline.height(0.5)
        
        if let placeholder = tf.placeholder {
            let attribute = [NSForegroundColorAttributeName: UIColor.white]
            tf.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: attribute)
        }
        
        
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        emailTextField.becomeFirstResponder()
    }
    
    override func setupView() {
        view.backgroundColor = UIColor.color(r: 0, g: 0, b: 0, alpha: 0.8)
        
        let closeButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "x_sign"), for: .normal)
            return button
            
        }()
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        let titleLabel: UILabel = {
            
            let label = UILabel()
            label.text = "Forgot Password"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        let instructionLabel: UILabel = {
            
            let label = UILabel()
            label.text = "Enter your email address to reset your password"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 17)
            label.textColor = .white
            label.textAlignment = .center
            label.numberOfLines = 2
            return label
        }()
        
        let resetButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Reset", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            button.createRoundCorner(4)
            button.createBorder(1, color: .white)
            
            return button
            
        }()
        resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(instructionLabel)
        view.addSubview(resetButton)
        view.addSubview(emailTextField)
        
        closeButton.square(edge: 44)
        closeButton.topLeft(toView: view, top: 16, left: 0)
        
        titleLabel.centerX(toView: view)
        titleLabel.centerY(toView: closeButton)
        
        instructionLabel.horizontal(toView: view, space: 32)
        instructionLabel.top(toView: view, space: screenHeight / 4)
        
        emailTextField.horizontal(toView: view, space: 16)
        emailTextField.centerY(toView: view, space: -32)
        emailTextField.height(40)
        
        resetButton.horizontal(toView: emailTextField)
        resetButton.verticalSpacing(toView: emailTextField, space: 24)
        resetButton.height(50)
    }
    
    func handleDismiss() {
        dismiss(animated: true)
    }
    
    func handleReset() {
        
    }
}































