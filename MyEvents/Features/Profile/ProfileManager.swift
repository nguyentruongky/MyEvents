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
    
    let nameTextField: UITextField = {
        
        let label = UITextField()
        label.text = "Ky Nguyen"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        let imageView: UIImageView = {
            
            let imageName = "edit"
            let iv = UIImageView(image: UIImage(named: imageName))
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            return iv
        }()
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEditName)))
        
        
        imageView.square(edge: 18)
        label.rightView = imageView
        label.rightViewMode = .always
        
        return label
    }()
    
    func handleEditName() {
        nameTextField.becomeFirstResponder()
    }
    
    
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
        headerView.addSubview(nameTextField)
        
        profileImageView.createRoundCorner(50)
        profileImageView.square(edge: 100)
        profileImageView.centerX(toView: headerView)
        profileImageView.top(toView: headerView, space: 32)
        
        nameTextField.centerX(toView: profileImageView)
        nameTextField.verticalSpacing(toView: profileImageView, space: 16)
        
        
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
