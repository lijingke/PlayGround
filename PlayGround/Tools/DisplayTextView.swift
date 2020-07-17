//
//  DisplayTextView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//


import UIKit

class DisplayTextView: UITextView {
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        self.resignFirstResponder()
        return false
    }
    
}
