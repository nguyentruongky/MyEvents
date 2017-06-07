//
//  NewEvent.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/7/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import GooglePlaces

class meNewEventController: knTableController {
    
    var datasource = [UITableViewCell]()
    
    let eventImageView: UIImageView = {
        
        let imageName = "camera_big"
        let iv = UIImageView(image: UIImage(named: imageName))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .center
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.green
        return iv
    }()
    
    let eventNameTextField = meNewEventController.makeTextField(placeholder: "Event name")
    
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
    
    lazy var addressTextField: UITextField = { [weak self] in
        
        let tf =  meNewEventController.makeTextField(placeholder: "Address")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickAddress), for: .touchUpInside)
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()
    
    func handlePickAddress() {
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
    
    static func makeTextField(placeholder: String) -> FloatLabelTextField {
        let tf = FloatLabelTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        tf.textColor = UIColor.color(value: 74)
        tf.placeholder = placeholder
        return tf

    }
    
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
    }
    
    override func setupView() {
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        datasource.append(makeEventImageCell())
        datasource.append(makeTextFieldCell(textField: eventNameTextField))
        datasource.append(makeTextFieldCell(textField: startDateTextField))
        datasource.append(makeTextFieldCell(textField: endDateTextField))
        datasource.append(makeTextFieldCell(textField: addressTextField))
        
        tableView.reloadData()
    }
    
    override func fetchData() {
        
    }

    func makeEventImageCell() -> UITableViewCell {
        
        let cell = knTableCell()
        
        cell.addSubview(eventImageView)
        eventImageView.fill(toView: cell, space: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
        eventImageView.height(150)
        
        eventImageView.isUserInteractionEnabled = true
        eventImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectImage)))
        
        return cell
    }
    
    func handleSelectImage() {
        
        func didSelectImage(_ image: UIImage) {
            eventImageView.image = image
            eventImageView.contentMode = .scaleAspectFill
        }
        
        knPhotoSelectorWorker(finishSelection: didSelectImage).execute()
    }
    
    func makeSeparator() -> UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.color(value: 222)
        view.height(1)
        return view
    }

    func makeTextFieldCell(textField: UITextField) -> UITableViewCell {
        let cell = knTableCell()
        
        cell.addSubview(textField)
        textField.horizontal(toView: cell, space: 16)
        textField.top(toView: cell)
        textField.height(40)
        
        let separator = makeSeparator()
        cell.addSubview(separator)
        separator.horizontal(toView: cell)
        separator.verticalSpacing(toView: textField, space: 16)
        separator.bottom(toView: cell, space: -16)
        
        return cell
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

extension meNewEventController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return datasource[indexPath.row]
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

