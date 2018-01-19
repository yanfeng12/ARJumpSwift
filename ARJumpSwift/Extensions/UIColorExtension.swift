//
//  UIColorExtension.swift
//  ARJumpSwift
//
//  Created by guopenglai on 2018/1/8.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func randomColor() -> UIColor {
        let r = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let g = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let b = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
