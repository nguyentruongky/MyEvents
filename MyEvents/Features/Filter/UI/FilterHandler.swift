//
//  FilterHandler.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation

extension meFilterController {

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

    func handleApplyFilter() {
        dismiss(animated: true)
        guard let name = eventNameTextField.text, let start = startDate, let end = endDate else { return }
        output?.filter(name: name, startDate: start, endDate: end)
    }
}
