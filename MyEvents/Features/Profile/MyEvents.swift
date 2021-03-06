//
//  MyEvents.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meMyEventsController: knTableController {
    
    var datasource = [meEventModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
    }
    
    override func setupView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func registerCells() {
        tableView.register(meEventItemCell.self, forCellReuseIdentifier: "meEventItemCell")
    }
    
    override func fetchData() {
        for _ in 0 ..< 3 {
            datasource.append(meEventModel(name: "Dr. Ted Malloch on “What the new US Presidential administration means for Brexit and the EU”",
                                           startDate: "23rd May 2017 2:00", endDate: "4:00 pm",
                                           address: "Head of Open Europe Brussels VZW"))
        }
        
        tableView.reloadData()
    }
}

extension meMyEventsController {
    
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

