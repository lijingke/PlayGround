//
//  UITableViewCell+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return NSStringFromClass(self as AnyClass).components(separatedBy: ".").last ?? ""
    }
    public static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
