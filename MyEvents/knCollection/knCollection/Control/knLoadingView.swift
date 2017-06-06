//
//  knLoadingView.swift
//  knLoading
//
//  Created by Ky Nguyen on 11/23/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

enum LoadingType: Int {
    
    case center, footer
}

class knLoading: NSObject {
    
    fileprivate override init() { }
    
    static let loading = knLoading()
    fileprivate var currentLoadingView : UIView?
    fileprivate var currentLoadingType: LoadingType?
    fileprivate var containerView: UIView?
    
    func showLoading(_ type: LoadingType, inView view: UIView, margin: UIEdgeInsets = UIEdgeInsets.zero) {
        
        containerView = view
        currentLoadingType = type
        currentLoadingView?.removeFromSuperview()
        
        switch type {
            
        case .center:
            showCenterLoadingView(toView: view)
            currentLoadingView = centerLoadingView
            break
            
        case .footer:
            showFooterLoadingView(toView: view, margin: margin)
            currentLoadingView = footerLoadingView
            break
            
        default:
            break
        }
    }
    
    func hideLoadingView() {
        
        guard let type = currentLoadingType else {
            currentLoadingView?.removeFromSuperview()
            return
        }
        
        switch type {
        case .footer:
            hideFooterLoadingView()
            break
            
        case .center:
            hideCenterLoadingView()
            break
        default:
            break
        }
    }
    
    
    // CENTER 
    
    fileprivate var centerLoadingView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        let icon = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        icon.startAnimating()
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    fileprivate func showCenterLoadingView(toView view: UIView) {
        view.addSubview(centerLoadingView)
        centerLoadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerLoadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerLoadingView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        centerLoadingView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        setCenterLoadingView(visibility: true)
    }
    
    fileprivate func hideCenterLoadingView() {
        
        setCenterLoadingView(visibility: false, completeHandler: {
            
            self.currentLoadingView = nil
            self.currentLoadingType = nil
            self.containerView = nil
            self.centerLoadingView.removeFromSuperview()
        })
    }
    
    fileprivate func setCenterLoadingView(visibility visible: Bool,
                                      completeHandler: ((Void) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.25, animations: { 
            
            self.centerLoadingView.alpha = visible ? 1 : 0
            
            }, completion: { (completed) in
                
                completeHandler?()
        }) 
    }
    
    // MARK: FOOTER
    
    fileprivate var footerLoadingView : UIView = {
        
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.75)
        
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Loading more..."
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = UIColor.white

        let icon = UIActivityIndicatorView(activityIndicatorStyle: .white)
        icon.startAnimating()
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text)
        view.addSubview(icon)
        
        // text constraint
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // icon constraint
        icon.rightAnchor.constraint(equalTo: text.leftAnchor, constant: -8).isActive = true
        icon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    fileprivate var footerBottom : NSLayoutConstraint?
    
    fileprivate func showFooterLoadingView(toView view: UIView, margin: UIEdgeInsets) {
        
        view.addSubview(footerLoadingView)
        
        footerLoadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        footerLoadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        footerBottom = footerLoadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 44 + margin.bottom)
        footerBottom?.isActive = true
        footerLoadingView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        view.layoutIfNeeded()
        setFooterLoadingView(visibility: true)
    }
    
    fileprivate func hideFooterLoadingView() {
        
        setFooterLoadingView(visibility: false, completeHandler: {
        
            self.currentLoadingView = nil
            self.currentLoadingType = nil
            self.containerView = nil
            self.footerLoadingView.removeFromSuperview()
        })
    }
    
    fileprivate func setFooterLoadingView(visibility visible: Bool,
                                      completeHandler: ((Void) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.25, animations: { 
            
            self.footerBottom?.constant = visible ? 0 : 44
            self.containerView?.layoutIfNeeded()
            
            }, completion: { (completed) in
                
                completeHandler?()       
        }) 
    }
    
    
}
