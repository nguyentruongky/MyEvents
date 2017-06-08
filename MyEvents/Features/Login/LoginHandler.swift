//
//  LoginHandler.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


/* action manager */
extension meLoginController {

    func handleLogin() {
        
        output?.login(email: emailTextField.text!, password: passwordTextField.text!)
    }

    func handleForgotPassword() {
        let controller = meForgotPasswordController()
        controller.email = emailTextField.text
        present(controller, animated: true)
    }

    func handleSignup() {
        let controller = meSignupController()
        navigationController?.pushViewController(controller, animated: true)
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
