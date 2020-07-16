//
//  UITableViewHeaderFooterView+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {
    
    public static var identifer: String {
        return NSStringFromClass(self as AnyClass).components(separatedBy: ".").last ?? ""
    }
    public static var nib: UINib {
        return UINib(nibName: self.identifer, bundle: nil)
    }
    
}
