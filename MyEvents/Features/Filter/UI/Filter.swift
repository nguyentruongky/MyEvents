//
//  Filter.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meFilterController: knController {
    
    weak var eventList: meEventListController?
    
    var output : meFilterControllerOutput?
    
    var startDate: Date?

    var endDate: Date?

    let eventNameTextField = meSupporter.makeFloatTextField(placeholder: "Event name")

    lazy var startDateTextField: UITextField = { [weak self] in
        
        let tf =  meSupporter.makeFloatTextField(placeholder: "Start date")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickStartDate), for: .touchUpInside)
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()

    lazy var endDateTextField: UITextField = { [weak self] in
        
        let tf =  meSupporter.makeFloatTextField(placeholder: "End date")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickEndDate), for: .touchUpInside)
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()

    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Filter"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    internal lazy var applyButton: UIButton = { [weak self] in
        let button = meSupporter.makeActionButton(title: "Apply")
        button.addTarget(self, action: #selector(handleApplyFilter), for: .touchUpInside)
        return button

        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        meFilterConfiguration.shared.configure(viewController: self)
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

