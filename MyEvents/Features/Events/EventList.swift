//
//  EventList.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/7/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

struct meEventModel {
    
    var name: String
    var startDate: String
    var endDate: String
    var address: String
    var image: String
}

class meEventListController: knTableController {
    
    var datasource = [meEventModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
    }
    
    override func setupView() {
        
        navigationItem.title = "Upcoming events"
        navigationController?.isNavigationBarHidden = false
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        
        let addEventButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(handleAddEvent))
        navigationItem.leftBarButtonItem = addEventButton
        
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .done, target: self, action: #selector(handleFilter))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    func handleAddEvent() {
        let controller = meNewEventController()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func handleFilter() {
        let controller = meFilterController()
        present(controller, animated: true)
    }
    
    override func registerCells() {
        tableView.register(meEventItemCell.self, forCellReuseIdentifier: "meEventItemCell")
    }
    
    override func fetchData() {
        
        for _ in 0 ..< 10 {
            datasource.append(meEventModel(name: "Dr. Ted Malloch on “What the new US Presidential administration means for Brexit and the EU”",
                                           startDate: "23rd May 2017 2:00", endDate: "4:00 pm",
                                           address: "Head of Open Europe Brussels VZW", image: "http://2ihmoy1d3v7630ar9h2rsglp.wpengine.netdna-cdn.com/wp-content/uploads/2017/03/Article-50-Brussels-event.jpg"))
        }
        
        tableView.reloadData()
    }
}

extension meEventListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meEventItemCell", for: indexPath) as! meEventItemCell
        cell.data = datasource[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}


final class meEventItemCell: knTableCell {
    
    var data: meEventModel? {
        didSet {
            guard let data = data else { return }
            eventImageView.downloadImage(from: data.image, placeholder: #imageLiteral(resourceName: "event_placeholder"))
            nameLabel.text = data.name
            timeLabel.text = "\(data.startDate) - \(data.endDate)"
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

















