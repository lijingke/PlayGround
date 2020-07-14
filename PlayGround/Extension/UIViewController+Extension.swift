//
//  UIViewController+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func getVCFromString(_ name: String) -> UIViewController? {
        let className = projectName + "." + name
        if let type = NSClassFromString(className) as? UIViewController.Type {
            return type.init()
        }else {
            return nil
        }
    }
    
}
