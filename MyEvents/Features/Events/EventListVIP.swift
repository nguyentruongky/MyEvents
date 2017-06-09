//
//  EventListVIP.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/9/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

/**
 Implementation
 1. Replace 'meEventList' to your controller's name
 2. Cut 'var output : meEventListControllerOutput? /* output */' to your real controller file -> Delete class 'meEventListController'
 3. Define actions controller needs in protocol meEventListControllerOutput
 4. Define actions to respond to result in protocol 'meEventListInteractorOutput'. For instance: requestSuccess, updateView...
 5. Conform actions from 'meEventListControllerOutput' in 'extension meEventListInteractor'
 6. Define actions to update directly to UI to 'meEventListPresenterOutput'
 7. Conform actions from 'meEventListInteractorOutput'
 8. Conform actions and update UI
 */



// 3
protocol meEventListControllerOutput: class {
    
    func fetchList()
}

// 4
protocol meEventListInteractorOutput: class {
    
    func fetchEventsSuccess(events: [meEventModel])

    func fetchEventsFail(_ error: knError)
}

// 5

extension meEventListInteractor: meEventListControllerOutput {
    
    func fetchList() {
        meFetchEventsWorker(success: output?.fetchEventsSuccess, fail: output?.fetchEventsFail).execute()
    }
}

// 6 - Define protocol to update directly to UI
protocol meEventListPresenterOutput: class {
    func displayEvents(_ events: [meEventModel])

    func displayFetchEventError(_ error: knError)
}


// 7: Convert Model to View Model to update UI
extension meEventListPresenter: meEventListInteractorOutput {
    
    func fetchEventsSuccess(events: [meEventModel]) {
        output?.displayEvents(events)
    }

    func fetchEventsFail(_ error: knError) {
        output?.displayFetchEventError(error)
    }
}


// 8 - Update UI
extension meEventListController: meEventListPresenterOutput {
    
    func displayEvents(_ events: [meEventModel]) {
        
        datasource.append(contentsOf: events)
        tableView.reloadData()
    }

    func displayFetchEventError(_ error: knError) {

        // test data 
        for _ in 0 ..< 3 {
            datasource.append(meEventModel(name: "Dr. Ted Malloch on “What the new US Presidential administration means for Brexit and the EU”",
                                           startDate: "23rd May 2017 2:00", endDate: "4:00 pm",
                                           address: "Head of Open Europe Brussels VZW"))
        }

        tableView.reloadData()
    }
}





class meEventListInteractor {
    
    var output: meEventListInteractorOutput?
}

class meEventListPresenter {
    
    weak var output: meEventListPresenterOutput?
}

//MARK: Configuration
class meEventListConfiguration /* called in viewDidLoad */ {
    
    static let shared = meEventListConfiguration()
    
    func configure(viewController: meEventListController) {
        
        // Presenter
        let presenter = meEventListPresenter()
        presenter.output = viewController
        
        // Interactor
        let interactor = meEventListInteractor()
        interactor.output = presenter
        
        // View controller
        viewController.output = interactor
    }
    
}

