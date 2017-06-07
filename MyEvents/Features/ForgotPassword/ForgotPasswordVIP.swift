//
//  ForgotPasswordVIP.swift
//  meco
//
//  Created by Ky Nguyen on 6/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meForgotPassword' to your controller's name
 2. Cut 'var output : meForgotPasswordControllerOutput? /* output */' to your real controller file -> Delete class 'meForgotPasswordController'
 3. Define actions controller needs in protocol meForgotPasswordControllerOutput
 4. Define actions to respond to result in protocol 'meForgotPasswordInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meForgotPasswordControllerOutput' in 'extension meForgotPasswordInteractor'
 6. Define actions to update directly to UI to 'meForgotPasswordPresenterOutput'
 7. Conform actions from 'meForgotPasswordInteractorOutput'
 8. Conform actions and update UI
 */



// 3
protocol meForgotPasswordControllerOutput: class {
    
    func validateEmail(_ email: String)
}

// 4
protocol meForgotPasswordInteractorOutput: class {
    
    func finishValidation(error: knError?)
}

// 5

extension meForgotPasswordInteractor: meForgotPasswordControllerOutput {
    
    func validateEmail(_ email: String) {
        meValidateEmailWorker(email: email, completion: output?.finishValidation).execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meForgotPasswordPresenterOutput: class {
    
    func displayValidationResult(error: knError?)
}


// 7: Convert Model to View Model to update UI
extension meForgotPasswordPresenter: meForgotPasswordInteractorOutput {
    
    func finishValidation(error: knError?) {
        output?.displayValidationResult(error: error)
    }
    
}


// 8 - Update UI
extension meForgotPasswordController: meForgotPasswordPresenterOutput {
    func displayValidationResult(error: knError?) {
        
    }
}





class meForgotPasswordInteractor {
    
    var output: meForgotPasswordInteractorOutput?
}

class meForgotPasswordPresenter {
    
    weak var output: meForgotPasswordPresenterOutput?
}

//meK: Configuration
class meForgotPasswordConfiguration /* called in viewDidLoad */ {
    
    static let shared = meForgotPasswordConfiguration()
    
    func configure(viewController: meForgotPasswordController) {
        
        // Presenter
        let presenter = meForgotPasswordPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meForgotPasswordInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}


