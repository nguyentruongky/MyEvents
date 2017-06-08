//
//  UserDetailVIP.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meUserDetail' to your controller's name
 2. Cut 'var output : meUserDetailControllerOutput? /* output */' to your real controller file -> Delete class 'meUserDetailController'
 3. Define actions controller needs in protocol meUserDetailControllerOutput
 4. Define actions to respond to result in protocol 'meUserDetailInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meUserDetailControllerOutput' in 'extension meUserDetailInteractor'
 6. Define actions to update directly to UI to 'meUserDetailPresenterOutput'
 7. Conform actions from 'meUserDetailInteractorOutput'
 8. Conform actions and update UI
 */



// 3
protocol meUserDetailControllerOutput: class {
    
    func fetchProfile(email: String)
    
    func updateProfile(email: String, name: String, address: [String])
}

// 4
protocol meUserDetailInteractorOutput: class {
    
    func fetchProfileSuccess(_ user: meUser)
    
    func updateProfileSuccess()
}

// 5

extension meUserDetailInteractor: meUserDetailControllerOutput {
    
    func fetchProfile(email: String) {
        meFetchProfileWorker(email: email, success: output?.fetchProfileSuccess, fail: nil).execute()
    }
    
    func updateProfile(email: String, name: String, address: [String]) {
        meUpdateProfileWorker(email: email, name: name, addresses: address,
                              success: output?.updateProfileSuccess, fail: nil).execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meUserDetailPresenterOutput: class {
    
    func displayProfile(_ user: meUser)
    
}


// 7: Convert Model to View Model to update UI
extension meUserDetailPresenter: meUserDetailInteractorOutput {
    
    func fetchProfileSuccess(_ user: meUser) {
        output?.displayProfile(user)
    }
    
    func updateProfileSuccess() {
        
    }
    
}


// 8 - Update UI
extension mePersonalDetailController: meUserDetailPresenterOutput {
    
    func displayProfile(_ user: meUser) {
        profileManager?.nameTextField.text = user.name
        emailTextField.text = user.email
        datasource.append(contentsOf: user.addresses.map({ return meAddressModel(address: $0) }))
    }
}





class meUserDetailInteractor {
    
    var output: meUserDetailInteractorOutput?
}

class meUserDetailPresenter {
    
    weak var output: meUserDetailPresenterOutput?
}

//MARK: Configuration
class meUserDetailConfiguration /* called in viewDidLoad */ {
    
    static let shared = meUserDetailConfiguration()
    
    func configure(viewController: mePersonalDetailController) {
        
        // Presenter
        let presenter = meUserDetailPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meUserDetailInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}

