//
//  knUIButton.swift
//  kynguyenCodebase
//
//  Created by Ky Nguyen on 12/9/16.
//  Copyright © 2016 kynguyen. All rights reserved.
//

import UIKit

extension UIButton {

    func setBackgroundColor(color: UIColor, forState: UIControlState) {

        let context = UIGraphicsGetCurrentContext()
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        context?.setFillColor(color.cgColor)
        context!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }

    func animate(atPosition position: CGPoint) {
        
        clipsToBounds = true
        CATransaction.begin()
        
        let startPath = UIBezierPath(arcCenter: position, radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = startPath.cgPath
        shapeLayer.fillColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.addSublayer(shapeLayer)
        
        CATransaction.setCompletionBlock({ [weak self] in
            shapeLayer.removeFromSuperlayer()
            self?.clipsToBounds = false
        })
        
        let endPath = UIBezierPath(arcCenter: position, radius: frame.size.width * 2, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: true)
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endPath.cgPath
        animation.duration = 0.4
        animation.isRemovedOnCompletion = true
        shapeLayer.add(animation, forKey: "scale")
        
        CATransaction.commit()
    }

}
