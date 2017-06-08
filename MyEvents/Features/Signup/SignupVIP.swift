//
//  SignupVIP.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meSignup' to your controller's name
 2. Cut 'var output : meSignupControllerOutput? /* output */' to your real controller file -> Delete class 'meSignupController'
 3. Define actions controller needs in protocol meSignupControllerOutput
 4. Define actions to respond to result in protocol 'meSignupInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meSignupControllerOutput' in 'extension meSignupInteractor'
 6. Define actions to update directly to UI to 'meSignupPresenterOutput'
 7. Conform actions from 'meSignupInteractorOutput'
 8. Conform actions and update UI
 */



// 3
protocol meSignupControllerOutput: class {
    
    func validate(email: String, password: String)
    
    func signup(email: String, password: String)
}

// 4
protocol meSignupInteractorOutput: class {
    
    func finishedValidation(error: knError?)
    
    func signupSuccess(user: meUser)
    
    func signupFail(error: knError)
}

// 5

extension meSignupInteractor: meSignupControllerOutput {
    
    func validate(email: String, password: String) {
        meValidateEmailPasswordWorker(email: email, password: password,
                                      completion: output?.finishedValidation).execute()
    }
    
    func signup(email: String, password: String) {
        meSignupWorker(email: email, password: password,
                       success: output?.signupSuccess, fail: output?.signupFail)
        .execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meSignupPresenterOutput: class {
    func displayValidationResult(_ error: knError?)
    
    func displaySignupSuccess(user: meUser)
    
    func displaySignupFail(error: knError)
}


// 7: Convert Model to View Model to update UI
extension meSignupPresenter: meSignupInteractorOutput {
    
    func finishedValidation(error: knError?) {
        output?.displayValidationResult(error)
    }
    
    func signupSuccess(user: meUser) {
        meSetting.currentUser = user
        output?.displaySignupSuccess(user: user)
    }
    
    func signupFail(error: knError) {
        output?.displaySignupFail(error: error)
    }
}


// 8 - Update UI
extension meSignupController: meSignupPresenterOutput {
    
    func displayValidationResult(_ error: knError?) {
        
        let isSuccess = error == nil
        
        func responseToFailValidation(_ error: knError) {
            signupButton.isEnabled = false
            signupButton.setTitleColor(UIColor.color(r: 141, g: 141, b: 141, alpha: 0.5), for: .normal)
            
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
            
            signupButton.isEnabled = true
            signupButton.setTitleColor(color141, for: .normal)
            
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
    
    func displaySignupSuccess(user: meUser) {
        
        let controller = meHomeManager()
        present(controller, animated: true)
        
        appDelegate.window?.rootViewController = controller
        
    }
    
    func displaySignupFail(error: knError) {
        // display error
    }
    
    
}





class meSignupInteractor {
    
    var output: meSignupInteractorOutput?
}

class meSignupPresenter {
    
    weak var output: meSignupPresenterOutput?
}

//meK: Configuration
class meSignupConfiguration /* called in viewDidLoad */ {
    
    static let shared = meSignupConfiguration()
    
    func configure(viewController: meSignupController) {
        
        // Presenter
        let presenter = meSignupPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meSignupInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}




