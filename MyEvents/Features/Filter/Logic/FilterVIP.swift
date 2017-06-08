//
//  FilterVIP.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meFilter' to your controller's name
 2. Cut 'var output : meFilterControllerOutput? /* output */' to your real controller file -> Delete class 'meFilterController'
 3. Define actions controller needs in protocol meFilterControllerOutput
 4. Define actions to respond to result in protocol 'meFilterInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meFilterControllerOutput' in 'extension meFilterInteractor'
 6. Define actions to update directly to UI to 'meFilterPresenterOutput'
 7. Conform actions from 'meFilterInteractorOutput'
 8. Conform actions and update UI
 */

// 3
protocol meFilterControllerOutput: class {
    
    func filter(name: String, startDate: Date, endDate: Date)
}

// 4
protocol meFilterInteractorOutput: class {
    
    func filterSuccess(events: [meEventModel])
    
}

// 5

extension meFilterInteractor: meFilterControllerOutput {
    
    func filter(name: String, startDate: Date, endDate: Date) {
        meFilterWorker(name: name, startDate: startDate, endDate: endDate,
                       success: output?.filterSuccess, fail: nil)
        .execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meFilterPresenterOutput: class {
    
    func displayFilterEvents(_ events: [meEventModel])
}


// 7: Convert Model to View Model to update UI
extension meFilterPresenter: meFilterInteractorOutput {
    func filterSuccess(events: [meEventModel]) {
        output?.displayFilterEvents(events)
    }
}


// 8 - Update UI
extension meFilterController: meFilterPresenterOutput {
    func displayFilterEvents(_ events: [meEventModel]) {
        
        eventList?.datasource = events
        eventList?.tableView.reloadData()
        dismiss(animated: true)
    }
}





class meFilterInteractor {
    
    var output: meFilterInteractorOutput?
}

class meFilterPresenter {
    
    weak var output: meFilterPresenterOutput?
}

//MARK: Configuration
class meFilterConfiguration /* called in viewDidLoad */ {
    
    static let shared = meFilterConfiguration()
    
    func configure(viewController: meFilterController) {
        
        // Presenter
        let presenter = meFilterPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meFilterInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}

