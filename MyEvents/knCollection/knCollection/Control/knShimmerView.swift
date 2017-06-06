//
//  knShimmerView.swift
//  kynguyenCodebase
//
//  Created by Ky Nguyen on 9/16/16.
//  Copyright © 2016 Larry Natalicio. All rights reserved.
//

import UIKit

@IBDesignable
class knShimmerView: UIView {
    
    fileprivate let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [UIColor.gray.cgColor,
                                UIColor.white.cgColor,
                                UIColor.gray.cgColor]
        gradientLayer.locations = [0.25, 0.5, 0.75]
        return gradientLayer
    }()
    
    fileprivate var textAttributes: [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [NSFontAttributeName: UIFont.systemFont(ofSize: 70),
                NSParagraphStyleAttributeName: style]
    }()
    
    @IBInspectable var text: String! {
        didSet {
            updateText(text)
        }
    }
    
    var font : UIFont! {
        didSet {
            textAttributes = createTextAttributes(font: font)
            if let text = text {
                updateText(text)
            }
        }
    }
    
    fileprivate func createTextAttributes(font: UIFont) -> [String: AnyObject] {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attribute = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style]
        return attribute
    }
    
    fileprivate func updateText(_ text: String) {
        setNeedsDisplay()
        let image = createImageFromText(text)
        let maskLayer = createImageMask(content: image)
        gradientLayer.mask = maskLayer
    }
    
    fileprivate func createImageFromText(_ text: String) -> UIImage {
        
        
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        text.draw(in: bounds, withAttributes: textAttributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    fileprivate func createImageMask(content: UIImage) -> CALayer {
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
        maskLayer.contents = content.cgImage
        return maskLayer
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = CGRect(x: -bounds.size.width,
                                     y: bounds.origin.y,
                                     width: 2 * bounds.size.width,
                                     height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
        let gradientAnimation = createGradientAnimation()
        gradientLayer.add(gradientAnimation, forKey: nil)
    }
    
    fileprivate func createGradientAnimation() -> CABasicAnimation{
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.75, 1.0, 1.0]
        gradientAnimation.duration = 1.7
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.fillMode = kCAFillModeForwards
        return gradientAnimation
    }
}
