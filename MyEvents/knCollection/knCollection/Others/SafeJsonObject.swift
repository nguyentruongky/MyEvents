//
//  SafeJsonObject.swift
//  kynguyenCodebase
//
//  Created by Ky Nguyen on 10/19/16.
//  Copyright © 2016 kynguyen. All rights reserved.
//

import UIKit

class SafeJsonObject : NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        
        let selectorName = key.capitalizingFirstLetter()
        let selector = NSSelectorFromString("set\(selectorName):")
        let response = self.responds(to: selector)
        
        guard response else { return }
        
        super.setValue(value, forKey: key)
    }
}

extension String {
    func capitalizingFirstCharacter() -> String {
        
        guard characters.count > 0 else { return self }
        
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return "\(first)\(other)"
    }
}
