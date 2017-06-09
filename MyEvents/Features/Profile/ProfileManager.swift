//
//  ProfileManager.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/8/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

class meProfileManager: knPagerController {

    private let headerViewHeight: CGFloat = 120

    lazy var profileImageView: UIImageView = { [weak self] in
        
        let iv = UIImageView(image: UIImage(named: "login"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChangeProfileImage)))
        
        return iv
    }()
    
    lazy var nameTextField: UITextField = { [weak self] in
        
        let tf = UITextField()
        tf.text = "Ky Nguyen"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.boldSystemFont(ofSize: 17)
        tf.textColor = .black
        tf.textAlignment = .center

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
        tf.rightView = imageView
        tf.rightViewMode = .always
        
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

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
        nameTextField.width(200)
        
        view.addSubview(headerView)
        headerView.height(200)
        headerView.horizontal(toView: view)
        headerView.top(toView: view)
        
        let signoutButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Signout", for: .normal)
            button.setTitleColor(UIColor.color(hex: "#999999"), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            return button
            
        }()
        
        headerView.addSubview(signoutButton)
        signoutButton.centerX(toView: profileImageView)
        signoutButton.verticalSpacing(toView: nameTextField, space: 4)
        
        signoutButton.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
    }
    
    func handleSignout() {
        
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
        detail.profileManager = self
        
        setupPager(tabNames: ["My Events", "Personal Detail"],
                   tabControllers: [events, detail])
        
    }
    
}


extension meProfileManager {


    func handleEditName() {
        nameTextField.becomeFirstResponder()
    }

    func handleChangeProfileImage() {

        func didSelectImage(_ image: UIImage) {
            profileImageView.image = image
        }

        knPhotoSelectorWorker(finishSelection: didSelectImage).execute()
    }

}
