//
//  UIImage+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/20.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

extension UIImage {
    
        static func getImage(from color: UIColor) -> UIImage {
        
        let frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        // 开始绘图
        UIGraphicsBeginImageContext(frame.size)
        // 获取绘图上下文
        let context = UIGraphicsGetCurrentContext()
        // 设置填充颜色
        context?.setFillColor(color.cgColor)
        // 使用填充颜色填充区域
        context?.fill(frame)
        // 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 结束绘图
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}
