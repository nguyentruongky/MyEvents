//
//  Login.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//


import UIKit

class meUser {
    
    var id: Int = 0
    var profileImage: String
    var name: String
    var email: String
    
    var token: String?
    
    init(profileImage: String, name: String, email: String) {
        self.profileImage = profileImage
        self.name = name
        self.email = email
        id = 0
    }
}

final class meLoginController: knTableController {
    
    var output : meLoginControllerOutput?
    
    fileprivate let backgroundImageView: UIImageView = {
        
        let imageName = "login"
        let iv = UIImageView(image: UIImage(named: imageName))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    internal lazy var emailTextField: UITextField = { [weak self] in
        
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = .black
        tf.placeholder = "Email"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.delegate = self
        tf.keyboardType = .emailAddress
        
        let underline = UIView()
        underline.tag = 101
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = UIColor.color(value: 141)
        
        tf.addSubview(underline)
        underline.horizontal(toView: tf)
        underline.bottom(toView: tf)
        underline.height(0.5)
        
        return tf
        }()
    
    internal lazy var passwordTextField: UITextField = { [weak self] in
        
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = .black
        tf.isSecureTextEntry = true
        tf.placeholder = "Password"
        tf.delegate = self
        
        let underline = UIView()
        underline.tag = 101
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.backgroundColor = UIColor.color(value: 141)
        
        tf.addSubview(underline)
        underline.horizontal(toView: tf)
        underline.bottom(toView: tf)
        underline.height(0.5)
        return tf
        }()
    
    internal lazy var loginButton: UIButton = { [weak self] in
        let button = UIButton()
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.color(r: 141, g: 141, b: 141, alpha: 0.5)
        button.createRoundCorner(22)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
        }()
    
    func handleLogin() {
        output?.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    fileprivate lazy var forgotPasswordButton: UIButton = { [weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot?", for: .normal)
        button.setTitleColor(UIColor.color(r: 141, g: 141, b: 141, alpha: 0.5), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
        }()
    
    fileprivate lazy var signupButton: UIButton = { [weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register new account", for: .normal)
        button.setTitleColor(UIColor.color(r: 141, g: 141, b: 141, alpha: 0.5), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
        }()
    
    func handleForgotPassword() {
        let controller = meForgotPasswordController()
        controller.email = emailTextField.text
        present(controller, animated: true)
    }
    
    func handleSignup() {
        
        let controller = meSignupController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meLoginConfiguration.shared.configure(viewController: self)
        setupView()
    }
    
    override func setupView() {
        
        navigationController?.isNavigationBarHidden = true
        
        let gradientViewHeight: CGFloat = screenHeight
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.setupGradientLayer(colors: [UIColor.clear, UIColor.white],
                                        size: CGSize(width: screenWidth, height: gradientViewHeight),
                                        startPoint: CGPoint(x: 0.5, y: 0),
                                        endPoint: CGPoint(x: 0.5, y: 1))
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(backgroundImageView)
        headerView.addSubview(gradientView)
        headerView.addSubview(emailTextField)
        headerView.addSubview(passwordTextField)
        headerView.addSubview(loginButton)
        headerView.addSubview(signupButton)
        
        gradientView.horizontal(toView: headerView)
        gradientView.height(gradientViewHeight)
        gradientView.bottom(toView: backgroundImageView)
        
        backgroundImageView.horizontal(toView: headerView)
        backgroundImageView.top(toView: headerView, space: DeviceType.IS_IPHONE_5 ? -32 : 0)
        backgroundImageView.square()
        
        passwordTextField.horizontal(toView: headerView, space: 16)
        passwordTextField.bottom(toView: backgroundImageView, space: DeviceType.IS_IPHONE_5 ? -16 : 0)
        passwordTextField.height(36)
        
        emailTextField.horizontal(toView: passwordTextField)
        passwordTextField.verticalSpacing(toView: emailTextField, space: 24)
        emailTextField.height(toView: passwordTextField)
        
        loginButton.horizontal(toView: headerView, space: 16)
        loginButton.verticalSpacing(toView: passwordTextField, space: 16)
        loginButton.height(44)
        
        passwordTextField.rightView = forgotPasswordButton
        passwordTextField.rightViewMode = .always
        
        signupButton.centerX(toView: loginButton)
        signupButton.verticalSpacing(toView: loginButton, space: 4)
        
        headerView.height(screenHeight)
        
        tableView.isScrollEnabled = false
        
        tableView.tableHeaderView = UIView()
        tableView.tableHeaderView?.frame.size.height = screenHeight
        tableView.tableHeaderView?.addSubview(headerView)
        tableView.tableHeaderView?.addConstraints(withFormat: "H:|[v0]|", views: headerView)
        tableView.tableHeaderView?.addConstraints(withFormat: "V:|[v0]", views: headerView)
        
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activateTextField()
    }
    
    func activateTextField() {
        if emailTextField.text == "" {
            emailTextField.becomeFirstResponder()
            return
        }
        
        if passwordTextField.text == "" {
            passwordTextField.becomeFirstResponder()
            return
        }
    }
    
}


extension meLoginController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(prepareToValidate), with: (textField, newText), afterDelay: 0.15)
        
        textField.text = newText
        return false
    }
    
    func prepareToValidate(data: Any) {
        guard let (textField, text) = data as? (UITextField, String) else { return }
        
        var email = ""
        var password = ""
        
        if textField == emailTextField {
            email = text
            password = passwordTextField.text!
        }
        else {
            email = emailTextField.text!
            password = text
        }
        
        output?.validate(email: email, password: password)
        
    }
}



















