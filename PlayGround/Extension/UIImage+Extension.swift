//
//  UIImage+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/20.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

extension UIImage {
    
    enum CropType {
        case top
        case center
        case bottom
    }
    
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
    
    //将图片裁剪成指定比例（多余部分自动删除）
    func crop(ratio: CGFloat, cropType: CropType) -> UIImage {
        
        //计算最终尺寸
        var newSize:CGSize!
        if size.width/size.height > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        }else{
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
        
        ////图片绘制区域
        var rect = CGRect.zero
        rect.size.width  = size.width
        rect.size.height = size.height

        switch cropType {
        case .top:
            rect.origin.x = 0
            rect.origin.y = 0
            break
        case .center:
            rect.origin.x = (newSize.width - size.width ) / 2.0
            rect.origin.y = (newSize.height - size.height ) / 2.0
            break
        case .bottom:
            rect.origin.x = newSize.width - size.width
            rect.origin.y = newSize.height - size.height
            break
        }
        
        //绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    
}
