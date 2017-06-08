//
//  UserAddressCell.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import GooglePlaces


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



