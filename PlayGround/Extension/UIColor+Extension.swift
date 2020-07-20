//
//  UIColor+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let r = (hex & 0xff0000) >> 16
        let g = (hex & 0xff00) >> 8
        let b = hex & 0xff
        self.init(red: CGFloat(r) / 0xff,
                  green: CGFloat(g) / 0xff,
                  blue: CGFloat(b) / 0xff,
                  alpha: alpha)
    }
    
    
    public static func rgb(hex: UInt32, alpha: CGFloat? = 1.0) -> UIColor {
        return UIColor(hex: hex, alpha: alpha ?? 1.0)
    }
    
    // 按钮禁止点击显示的浅灰色
    public static var enabled: UIColor {
        return UIColor.rgb(hex: 0xB6B7C1)
    }
}
