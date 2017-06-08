//
//  NewEventVIP.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meNewEvent' to your controller's name
 2. Cut 'var output : meNewEventControllerOutput? /* output */' to your real controller file -> Delete class 'meNewEventController'
 3. Define actions controller needs in protocol meNewEventControllerOutput
 4. Define actions to respond to result in protocol 'meNewEventInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meNewEventControllerOutput' in 'extension meNewEventInteractor'
 6. Define actions to update directly to UI to 'meNewEventPresenterOutput'
 7. Conform actions from 'meNewEventInteractorOutput'
 8. Conform actions and update UI
 */


// 3
protocol meNewEventControllerOutput: class {
    
    func createEvent(name: String, startDate: Date, endDate: Date)
}

// 4
protocol meNewEventInteractorOutput: class {
    
    func createEventSuccess(event: meEventModel)
    
    func createEventError(_ error: knError)
}

// 5

extension meNewEventInteractor: meNewEventControllerOutput {
    
    func createEvent(name: String, startDate: Date, endDate: Date) {
        meCreateEventWorker(name: name, startDate: startDate, endDate: endDate,
                            success: output?.createEventSuccess, fail: output?.createEventError)
        .execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meNewEventPresenterOutput: class {
    
    func displayEvent(_ event: meEventModel)
    
    func displayCreateError(_ error: knError)
}


// 7: Convert Model to View Model to update UI
extension meNewEventPresenter: meNewEventInteractorOutput {
    
    func createEventSuccess(event: meEventModel) {
        output?.displayEvent(event)
    }
    
    func createEventError(_ error: knError) {
        output?.displayCreateError(error)
    }
    
}


// 8 - Update UI
extension meNewEventController: meNewEventPresenterOutput {
    
    func displayEvent(_ event: meEventModel) {
        navigationController?.popViewController(animated: true)
        eventList?.datasource.insert(event, at: 0)
        eventList?.tableView.reloadData()
    }
    
    func displayCreateError(_ error: knError) {
        // display error
    }
    
}





class meNewEventInteractor {
    
    var output: meNewEventInteractorOutput?
}

class meNewEventPresenter {
    
    weak var output: meNewEventPresenterOutput?
}

//MARK: Configuration
class meNewEventConfiguration /* called in viewDidLoad */ {
    
    static let shared = meNewEventConfiguration()
    
    func configure(viewController: meNewEventController) {
        
        // Presenter
        let presenter = meNewEventPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meNewEventInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}

