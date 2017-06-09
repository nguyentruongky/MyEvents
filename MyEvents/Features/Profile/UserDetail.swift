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
    
    weak var profileManager: meProfileManager?
    
    var output : meUserDetailControllerOutput?
    
    var datasource = [meAddressModel]()

    let emailTextField: FloatLabelTextField = {
        
        let tf =  meSupporter.makeFloatTextField(placeholder: "Email")
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        tf.addSubview(button)
        button.fill(toView: tf)
        
        return tf
        }()
    
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        meUserDetailConfiguration.shared.configure(viewController: self)
        setupView()
    }

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    override func fetchData() {
        if let email = meSetting.currentUserEmail {
            output?.fetchProfile(email: email)
        }
        
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {

            datasource.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        let controller = GMSAutocompleteViewController()
        controller.delegate = self
        present(controller, animated: true)
        
    }
    
}



