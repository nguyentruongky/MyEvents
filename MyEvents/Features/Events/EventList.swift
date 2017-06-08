//
//  EventList.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/7/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

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


/* action manager */
extension meEventListController {

    func handleAddEvent() {
        let controller = meNewEventController()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }

    func handleFilter() {
        let controller = meFilterController()
        present(controller, animated: true)
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

















