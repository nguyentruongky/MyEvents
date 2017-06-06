//
//  knTableController.swift
//  Ogenii
//
//  Created by Ky Nguyen on 3/17/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class knTableController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        registerCells()
    }
    
    func setupView() { }
    
    func registerCells() { }
    
    func fetchData() { }
 
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}

extension knTableController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



class knCustomTableController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        registerCells()
    }
    
    lazy var tableView: UITableView = { [weak self] in
        
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.dataSource = self
        tb.delegate = self
        return tb
        
    }()
    
    func setupView() { }
    
    func registerCells() { }
    
    func fetchData() { }
    
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}

extension knCustomTableController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


