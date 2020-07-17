//
//  UINavigationBar+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

extension UINavigationBar {
    // 获取导航栏的分隔线
    
    func getNaviLine() -> UIImageView? {
        findNavLineView(view: self)
    }
    
    private func findNavLineView(view: UIView?) -> UIImageView? {
        
        if let view = view {
            if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
                return view as? UIImageView
            }
            
            for subView in view.subviews {
                let imageView = findNavLineView(view: subView)
                if imageView != nil {
                    return imageView
                }
            }
        }
        
        return nil
    }
}
