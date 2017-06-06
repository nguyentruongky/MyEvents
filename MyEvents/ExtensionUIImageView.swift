//
//  ExtensionUIImageView.swift
//  MyEvents
//
//  Created by Ky Nguyen on 6/7/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func downloadImage(from url: String?, placeholder: UIImage? = nil) {
        
        guard let url = url, let nsurl = URL(string: url) else { return }
        kf.setImage(with: ImageResource(downloadURL: nsurl), placeholder: placeholder)
    }
    
}
