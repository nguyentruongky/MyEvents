//
//  knInt.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/23/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit

public extension UInt32 {
    
    // prevent overflow with Int and Int32
    public static func random(lower: UInt32 = min, upper: UInt32 = max / 2) -> Int {
        return Int(arc4random_uniform(upper - lower - 10) + lower)
    }
}
