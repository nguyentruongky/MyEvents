//
//  EventCell.swift
//  MyEvents
//
//  Created by OSX on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


final class meEventItemCell: knTableCell {

    var data: meEventModel? {
        didSet {
            guard let data = data else { return }
            eventImageView.downloadImage(from: data.image, placeholder: #imageLiteral(resourceName: "event_placeholder"))
            nameLabel.text = data.name
            if let start = data.startDate, let end = data.endDate {
                timeLabel.text = "\(start) to \(end)"
            }
            else {
                timeLabel.text = "Some dates"
            }
            addressLabel.text = data.address
        }
    }

    private let eventImageView: UIImageView = {

        let imageName = "event_placeholder"
        let iv = UIImageView(image: UIImage(named: imageName))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let nameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.color(value: 74)
        label.numberOfLines = 0
        return label
    }()

    private let timeLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.color(value: 74)
        return label
    }()

    private let addressLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.color(value: 74)
        return label
    }()


    override func setupView() {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let timeIcon: UIImageView = {

            let imageName = "time"
            let iv = UIImageView(image: UIImage(named: imageName))
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()

        let addressIcon: UIImageView = {

            let imageName = "address"
            let iv = UIImageView(image: UIImage(named: imageName))
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()

        view.addSubview(eventImageView)
        view.addSubview(nameLabel)
        view.addSubview(timeLabel)
        view.addSubview(timeIcon)
        view.addSubview(addressLabel)
        view.addSubview(addressIcon)

        eventImageView.top(toView: view)
        eventImageView.horizontal(toView: view)
        eventImageView.height(150)

        nameLabel.horizontal(toView: view, space: 16)
        nameLabel.verticalSpacing(toView: eventImageView, space: 8)

        timeIcon.left(toView: nameLabel)
        timeIcon.square(edge: 16)
        timeIcon.horizontalSpacing(toView: timeLabel, space: 6)
        timeIcon.centerY(toView: timeLabel)

        timeLabel.verticalSpacing(toView: nameLabel, space: 12)
        timeLabel.right(toView: view, space: -16)

        addressIcon.left(toView: timeIcon)
        addressIcon.size(toView: timeIcon)
        addressIcon.centerY(toView: addressLabel)

        addressLabel.horizontal(toView: timeLabel)
        addressLabel.verticalSpacing(toView: timeLabel, space: 8)
        addressLabel.bottom(toView: view, space: -16)


        view.createRoundCorner(4)
        view.createBorder(1, color: UIColor.color(value: 222))

        addSubview(view)
        view.fill(toView: self, space: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
    }


}


