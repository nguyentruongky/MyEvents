//
//  Filter.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meFilterController: knController {
    
    let eventNameTextField = meNewEventController.makeTextField(placeholder: "Event name")
    
    var startDate: Date?
    var endDate: Date?
    
    lazy var startDateTextField: UITextField = { [weak self] in
        
        let tf =  meNewEventController.makeTextField(placeholder: "Start date")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickStartDate), for: .touchUpInside)
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()
    
    func handlePickStartDate() {
        DatePickerDialog().show("Select Start date", doneButtonTitle: "Confirm", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .dateAndTime, callback: { [weak self] date in
            
            guard let _self = self, let date = date else { return }
            _self.startDateTextField.text = date.toString("MM/dd/yyyy - hh:mm a")
            _self.startDate = date
        })
    }
    
    lazy var endDateTextField: UITextField = { [weak self] in
        
        let tf =  meNewEventController.makeTextField(placeholder: "End date")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickEndDate), for: .touchUpInside)
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()
    
    func handlePickEndDate() {
        DatePickerDialog().show("Select End date", doneButtonTitle: "Confirm", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .dateAndTime, callback: { [weak self] date in
            
            guard let _self = self, let date = date else { return }
            _self.endDateTextField.text = date.toString("MM/dd/yyyy - hh:mm a")
            _self.endDate = date
        })
    }
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Filter"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    internal lazy var applyButton: UIButton = { [weak self] in
        let button = UIButton()
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor.color(r: 141, g: 141, b: 141, alpha: 0.5)
        button.createRoundCorner(22)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleApplyFilter), for: .touchUpInside)
        return button
        }()
    
    func handleApplyFilter() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    override func setupView() {
        
        view.backgroundColor = UIColor.color(r: 0, g: 0, b: 0, alpha: 0.8)
        
        let closeButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "x_sign"), for: .normal)
            return button
        }()
        
        closeButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(eventNameTextField)
        view.addSubview(startDateTextField)
        view.addSubview(endDateTextField)
        view.addSubview(applyButton)
        
        closeButton.square(edge: 44)
        closeButton.topLeft(toView: view, top: 16, left: 0)
        
        titleLabel.centerX(toView: view)
        titleLabel.centerY(toView: closeButton)
        
        view.addConstraints(withFormat: "V:|-64-[v0]-16-[v1]-16-[v2]-16-[v3]",
                            views: eventNameTextField, startDateTextField, endDateTextField, applyButton)
        eventNameTextField.horizontal(toView: view, space: 16)
        startDateTextField.horizontal(toView: eventNameTextField)
        endDateTextField.horizontal(toView: eventNameTextField)
        applyButton.horizontal(toView: eventNameTextField)
        applyButton.height(44)
        eventNameTextField.height(toView: applyButton)
        startDateTextField.height(toView: applyButton)
        endDateTextField.height(toView: applyButton)
        
        eventNameTextField.backgroundColor = .white
        eventNameTextField.createRoundCorner(5)
        
        startDateTextField.backgroundColor = .white
        startDateTextField.createRoundCorner(5)
        
        endDateTextField.backgroundColor = .white
        endDateTextField.createRoundCorner(5)
    }
    
}

