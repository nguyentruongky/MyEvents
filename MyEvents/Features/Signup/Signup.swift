//
//  Signup.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meSignupController: knTableController {
    
    var output: meSignupControllerOutput?

    internal lazy var emailTextField: UITextField = { [weak self] in

        let tf = meSupporter.makeFloatTextField(placeholder: "Email")
        tf.delegate = self
        tf.keyboardType = .emailAddress
        return tf

        }()

    internal lazy var passwordTextField: UITextField = { [weak self] in

        let tf = meSupporter.makeFloatTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        tf.delegate = self
        return tf

        }()

    internal lazy var signupButton: UIButton = { [weak self] in
        let button = meSupporter.makeActionButton(title: "Register")
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        meSignupConfiguration.shared.configure(viewController: self)
        setupView()
    }
    
    override func setupView() {
        
        navigationController?.isNavigationBarHidden = true

        let backgroundImageView: UIImageView = {

            let imageName = "register"
            let iv = UIImageView(image: UIImage(named: imageName))
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()

        let gradientViewHeight: CGFloat = screenHeight
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.setupGradientLayer(colors: [UIColor.clear, UIColor.white],
                                        size: CGSize(width: screenWidth, height: gradientViewHeight),
                                        startPoint: CGPoint(x: 0.5, y: 0),
                                        endPoint: CGPoint(x: 0.5, y: 1))
        
        let backButton: UIButton = {
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "back"), for: .normal)
            return button
        }()
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(backgroundImageView)
        headerView.addSubview(gradientView)
        headerView.addSubview(emailTextField)
        headerView.addSubview(passwordTextField)
        headerView.addSubview(signupButton)
        headerView.addSubview(backButton)
        
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
        
        signupButton.height(44)
        signupButton.horizontal(toView: headerView, space: 16)
        signupButton.verticalSpacing(toView: passwordTextField, space: 16)
        
        backButton.square(edge: 44)
        backButton.topLeft(toView: headerView, top: 16, left: 8)
        
        headerView.height(screenHeight)
        
        tableView.isScrollEnabled = false
        
        tableView.tableHeaderView = UIView()
        tableView.tableHeaderView?.frame.size.height = screenHeight
        tableView.tableHeaderView?.addSubview(headerView)
        tableView.tableHeaderView?.addConstraints(withFormat: "H:|[v0]|", views: headerView)
        tableView.tableHeaderView?.addConstraints(withFormat: "V:|[v0]", views: headerView)
        
        emailTextField.becomeFirstResponder()
    }
    
    override func fetchData() {
        
    }
    
}



























