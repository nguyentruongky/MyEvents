//
//  LoginVIP.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meLogin' to your controller's name
 2. Cut 'var output : meLoginControllerOutput? /* output */' to your real controller file -> Delete class 'meLoginController'
 3. Define actions controller needs in protocol meLoginControllerOutput
 4. Define actions to respond to result in protocol 'meLoginInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meLoginControllerOutput' in 'extension meLoginInteractor'
 6. Define actions to update directly to UI to 'meLoginPresenterOutput'
 7. Conform actions from 'meLoginInteractorOutput'
 8. Conform actions and update UI
 */



// 3
protocol meLoginControllerOutput: class {
    
    func validate(email: String, password: String)
    
    func login(email: String, password: String)
}

// 4
protocol meLoginInteractorOutput: class {
    
    func finishedValidation(error: knError?)
    
    func loginSuccess(user: meUser)
    
    func loginFail(error: knError)
}

// 5

extension meLoginInteractor: meLoginControllerOutput {
    
    func validate(email: String, password: String) {
        meValidateEmailPasswordWorker(email: email, password: password,
                                      completion: output?.finishedValidation).execute()
    }
    
    func login(email: String, password: String) {
        meLoginWorker(email: email, password: password,
                      success: output?.loginSuccess, fail: output?.loginFail)
        .execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meLoginPresenterOutput: class {
    
    func displayValidationResult(_ error: knError?)
    
    func loginSuccess(user: meUser)
    
    func loginFail(error: knError)
}


// 7: Convert Model to View Model to update UI
extension meLoginPresenter: meLoginInteractorOutput {
    
    func finishedValidation(error: knError?) {
        output?.displayValidationResult(error)
    }
    
    
    func loginSuccess(user: meUser) {
        
        meSetting.currentUser = user
        
        output?.loginSuccess(user: user)
        
    }
    
    func loginFail(error: knError) {
        loginFail(error: error)
    }
}


// 8 - Update UI
extension meLoginController: meLoginPresenterOutput {
    
    func displayValidationResult(_ error: knError?) {
        
        let isSuccess = error == nil
        
        func responseToFailValidation(_ error: knError) {
            loginButton.isEnabled = false

            var errorTextField: UITextField!
            
            switch error.code! {
            case .emptyEmail, .invalidEmail:
                errorTextField = emailTextField
                
            case .emptyPassword, .invalidPassword:
                errorTextField = passwordTextField
                
            default:
                break
            }
            
            errorTextField.viewWithTag(101)?.backgroundColor = UIColor.color(r: 255, g: 56, b: 36)
        }
        
        func responseToSuccessValidation() {
            
            let color141 = UIColor.color(value: 141)
            
            loginButton.isEnabled = true
            
            emailTextField.viewWithTag(101)?.backgroundColor = color141
            passwordTextField.viewWithTag(101)?.backgroundColor = color141
            
        }
        
        if isSuccess == true {
            responseToSuccessValidation()
        }
        else {
            responseToFailValidation(error!)
        }
    }
    
    func loginSuccess(user: meUser) {
        let controller = meHomeManager()
        present(controller, animated: true)
    }
    
    
    func loginFail(error: knError) {
        // display error
    }
    
    
}





class meLoginInteractor {
    
    var output: meLoginInteractorOutput?
}

class meLoginPresenter {
    
    weak var output: meLoginPresenterOutput?
}

//meK: Configuration
class meLoginConfiguration /* called in viewDidLoad */ {
    
    static let shared = meLoginConfiguration()
    
    func configure(viewController: meLoginController) {
        
        // Presenter
        let presenter = meLoginPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meLoginInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}



