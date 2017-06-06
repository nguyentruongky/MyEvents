//
//  knUINavigationController.swift
//  kynguyenCodebase
//
//  Created by Ky Nguyen on 11/25/16.
//  Copyright © 2016 kynguyen. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func setNavigationBarHidden(inScrollviewScrolling scrollView: UIScrollView) {
        
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if actualPosition.y > 0 {
            setNavigationBarHidden(false, animated: true)
            return
        }
        setNavigationBarHidden(scrollView.contentOffset.y > 24, animated: true)
    }
    
    func changeTitleFont(_ font: UIFont, color: UIColor = .white) {
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
    }
    
    func fillNavigationBar(with color: UIColor) {
        navigationBar.barTintColor = color
        navigationBar.tintColor = .white
    }
    
    func fillNavigationBar(withColors colors: [CGColor],
                           startPoint: CGPoint = CGPoint(x: 0, y: 0),
                           endPoint: CGPoint = CGPoint(x: 1, y: 1)) {
        
        let gradientLayer = CAGradientLayer()
        var updatedFrame = navigationBar.bounds
        updatedFrame.size.height += 20
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        let image = gradientLayer.renderImage()
        navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }
}

extension CALayer {
    
    func renderImage() -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
