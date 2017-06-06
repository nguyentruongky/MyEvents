//
//  knPagerController.swift
//  Fixir
//
//  Created by Ky Nguyen on 4/5/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit


class knPagerController : PagerController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setupTabsController()
        
        formatTabIndicator()
        
        setupView()
    }
    
    /* need override */
    func setupTabsController() { }
    
    func setupView() {
        
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = true
        setupNavigationBar()
    }
    
    /* override if needed */
    func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)]
    }
    
    func formatTabIndicator() {
        tabsViewBackgroundColor = .white
//        indicatorColor = fxColor.fx_119_203_189
//        tabsTextColor = fxColor.fx_119_203_189
//        selectedTabTextColor = fxColor.fx_119_203_189
//        tabsTextFont = fxFont.font(size: 14)
        
        centerCurrentTab = true
        tabTopOffset = 0
        tabHeight = 40
        indicatorHeight = 2
        tabLocation = .top
        animation = .during
    }
    
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
    
}


extension knPagerController : PagerDataSource {
    
    func numberOfTabs(_ pager: PagerController) -> Int {
        return 2
    }
}

