//
//  UserDetail.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import GooglePlaces

struct meAddressModel {
    
    var address: String
    
}

class mePersonalDetailController: knTableController {
    
    var datasource = [meAddressModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
    }
    
    let emailTextField: FloatLabelTextField = {
        
        let tf =  meNewEventController.makeTextField(placeholder: "Address")
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        tf.text = "nguyen@gmail.com"
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()
    
    var selectedIndex: Int?
    
    override func setupView() {
        
        let addressesLabel: UILabel = {
            
            let label = UILabel()
            label.text = "Your addresses"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = .black
            return label
        }()

        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(emailTextField)
        headerView.addSubview(addressesLabel)
        
        emailTextField.height(44)
        emailTextField.horizontal(toView: headerView, space: 16)
        emailTextField.top(toView: headerView, space: 16)
        
        addressesLabel.horizontal(toView: emailTextField)
        addressesLabel.verticalSpacing(toView: emailTextField, space: 16)
        
        let headerHeight: CGFloat = 110
        
        tableView.tableHeaderView = UIView()
        tableView.tableHeaderView?.frame.size.height = headerHeight
        tableView.tableHeaderView?.addSubview(headerView)
        tableView.tableHeaderView?.addConstraints(withFormat: "H:|[v0]|", views: headerView)
        tableView.tableHeaderView?.addConstraints(withFormat: "V:|[v0]", views: headerView)
        
    }
    
    override func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(meAddNewAddressCell.self, forCellReuseIdentifier: "meAddNewAddressCell")
    }
    
    override func fetchData() {
        
        datasource.append(meAddressModel(address: "Ton Duc Thang"))
        datasource.append(meAddressModel(address: "Tran Phu"))
        datasource.append(meAddressModel(address: "Le Dai Hanh"))
        datasource.append(meAddressModel(address: "Tran Hung Dao "))
        
    }
}

extension mePersonalDetailController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isExtraCell(index: indexPath.row) == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "meAddNewAddressCell",
                                                     for: indexPath) as! meAddNewAddressCell
            cell.parent = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = datasource[indexPath.row].address
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func isExtraCell(index: Int) -> Bool {
        return index == datasource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return isExtraCell(index: indexPath.row) == true ? 76 : 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        present(controller, animated: true)
        
    }
    
}


extension mePersonalDetailController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true)
        
        guard let address = place.formattedAddress, let index = selectedIndex else { return }
        datasource[index] = meAddressModel(address: address)
        tableView.reloadData()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true)
    }
}



class meAddNewAddressCell: knTableCell {
    
    weak var parent: mePersonalDetailController?
    
    internal lazy var addButton: UIButton = { [weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.color(r: 141, g: 141, b: 141, alpha: 0.5)
        button.createRoundCorner(22)
        button.setTitle("Add new address", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleAddAddress), for: .touchUpInside)
        return button
        }()
    
    func handleAddAddress() {
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        parent?.present(controller, animated: true)
    }
    
    override func setupView() {
        
        addSubview(addButton)
        addButton.fill(toView: self, space: UIEdgeInsets(space: 16))
        addButton.height(44)
    }
    
}


extension meAddNewAddressCell: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        viewController.dismiss(animated: true)
        
        guard let address = place.formattedAddress else { return }
        parent?.datasource.append(meAddressModel(address: address))
        parent?.tableView.reloadData()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true)
    }
}




