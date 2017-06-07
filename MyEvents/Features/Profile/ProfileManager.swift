//
//  ProfileManager.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meProfileManager: knPagerController {
    
    lazy var profileImageView: UIImageView = { [weak self] in
        
        let iv = UIImageView(image: UIImage(named: "login"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeProfileImage)))
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Ky Nguyen"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private let headerViewHeight: CGFloat = 120
    
    override func setupView() {
        
        navigationController?.isNavigationBarHidden = true
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(profileImageView)
        headerView.addSubview(nameLabel)
        
        profileImageView.createRoundCorner(50)
        profileImageView.square(edge: 100)
        profileImageView.centerX(toView: headerView)
        profileImageView.top(toView: headerView, space: 32)
        
        nameLabel.centerX(toView: profileImageView)
        nameLabel.verticalSpacing(toView: profileImageView, space: 16)
        
        
        view.addSubview(headerView)
        headerView.height(headerViewHeight)
        headerView.horizontal(toView: view)
        headerView.top(toView: view)
        
        
    }
    
    func handleChangeProfileImage() {
        
        func didSelectImage(_ image: UIImage) {
            profileImageView.image = image
        }
        
        knPhotoSelectorWorker(finishSelection: didSelectImage).execute()
    }
    
    override func formatTabIndicator() {
        
        tabsViewBackgroundColor = .white
        tabsTextColor = UIColor.color(value: 167)
        selectedTabTextColor = UIColor.color(value: 25)
        tabsTextFont = UIFont.boldSystemFont(ofSize: 15)
        
        centerCurrentTab = true
        tabTopOffset = headerViewHeight
        tabHeight = 44
        indicatorHeight = 3
        tabLocation = .top
        animation = .during
        
    }
    
    override func setupTabsController() {
        
        let events = meMyEventsController()
        let detail = mePersonalDetailController()
        
        setupPager(tabNames: ["My Events", "Personal Detail"],
                   tabControllers: [events, detail])
        
    }
    
}
