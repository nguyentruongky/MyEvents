//
//  NewEvent.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/7/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meNewEventController: knTableController {
    
    var output : meNewEventControllerOutput?
    
    weak var eventList: meEventListController?
    
    var startDate: Date?

    var endDate: Date?

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

    lazy var addressTextField: UITextField = { [weak self] in
        
        let tf =  meSupporter.makeFloatTextField(placeholder: "Address")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePickAddress), for: .touchUpInside)
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        meNewEventConfiguration.shared.configure(viewController: self)
        setupView()
        fetchData()
    }
    
    override func setupView() {
        
        customBackArrow(tintColor: .blue)
        
        title = "New Event"
        
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
        
        eventNameTextField.viewWithTag(101)?.removeFromSuperview()
        startDateTextField.viewWithTag(101)?.removeFromSuperview()
        endDateTextField.viewWithTag(101)?.removeFromSuperview()
        addressTextField.viewWithTag(101)?.removeFromSuperview()
        
        tableView.reloadData()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleCreateEvent))
        navigationItem.rightBarButtonItem = saveButton
        
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

