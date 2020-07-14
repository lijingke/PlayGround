//
//  UIView+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/10.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 部分圆角
    /// - Parameters:
    ///   - conrners: 需要实现为圆角的角，可传入多个
    ///   - radius: 圆角半径
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func cornerWithRadius(redius:CGFloat){
        
        self.cornerWithRadiusrectCornerType(radius: redius, rectCornerType: UIRectCorner.allCorners)
    }
    
    func cornerWithRadiusrectCornerType(radius:CGFloat,rectCornerType:UIRectCorner){
        let maskPath:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: rectCornerType, cornerRadii: CGSize(width:radius, height:radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func cornerShadowWithRadius(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColorFromRGB(rgbValue: 0xc7c7c7).cgColor
        self.layer.shadowOffset = CGSize(width:0, height:1)//偏移距离
        self.layer.shadowOpacity = 0.5//不透明度
        self.layer.shadowRadius = 5.0//半径
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func UIColorFromRGB(rgbValue: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    func setShadow(_ radius: CGFloat? = nil) {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.rgb(hex: 0xc7c7c7).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = radius ?? 6
    }
}
