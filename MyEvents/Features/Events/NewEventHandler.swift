//
//  NewEventHandler.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import GooglePlaces

extension meNewEventController {

    func handlePickStartDate() {
        DatePickerDialog().show("Select Start date", doneButtonTitle: "Confirm", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .dateAndTime, callback: { [weak self] date in

            guard let _self = self, let date = date else { return }
            _self.startDateTextField.text = date.toString("MM/dd/yyyy - hh:mm a")
            _self.startDate = date
        })
    }

    func handlePickEndDate() {
        DatePickerDialog().show("Select End date", doneButtonTitle: "Confirm", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .dateAndTime, callback: { [weak self] date in

            guard let _self = self, let date = date else { return }
            _self.endDateTextField.text = date.toString("MM/dd/yyyy - hh:mm a")
            _self.endDate = date
        })
    }

    func handlePickAddress() {
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
    func handleCreateEvent() {
        guard let name = eventNameTextField.text, let startDate = startDate, let endDate = endDate else { return }
        output?.createEvent(name: name, startDate: startDate, endDate: endDate)
    }
}

extension meNewEventController: GMSAutocompleteViewControllerDelegate {

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        addressTextField.text = place.formattedAddress
        viewController.dismiss(animated: true)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        viewController.dismiss(animated: true)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true)
    }
}



extension meNewEventController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == startDateTextField || textField == endDateTextField {
            return false
        }

        return true
    }
    
}
