//
//  UIButton+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/13.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit
// MARK: - 快速设置按钮 并监听点击事件
typealias  buttonClick = (()->()) // 定义数据类型(其实就是设置别名)
extension UIButton {
    // 改进写法【推荐】
    private struct HWRuntimeKey {
        static let actionBlock = UnsafeRawPointer.init(bitPattern: "actionBlock".hashValue)
        static let delay = UnsafeRawPointer.init(bitPattern: "delay".hashValue)
        /// ...其他Key声明
    }
    /// 运行时关联
    private var actionBlock: buttonClick? {
        set {
            objc_setAssociatedObject(self, UIButton.HWRuntimeKey.actionBlock!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIButton.HWRuntimeKey.actionBlock!) as? buttonClick
        }
    }
    private var delay: TimeInterval {
        set {
            objc_setAssociatedObject(self, UIButton.HWRuntimeKey.delay!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, UIButton.HWRuntimeKey.delay!) as? TimeInterval ?? 0
        }
    }
    /// 点击回调
    @objc private func tapped(button:UIButton) {
        actionBlock?()
        isEnabled = false
        // 4.GCD 主线程/子线程
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in // 延迟调用方法
            DispatchQueue.main.async { // 不知道有没有用反正写上就对了
                print("恢复时间\(Date())")
                self?.isEnabled = true
            }
        }
    }
    /// 添加点击事件
    func addAction(_ delay: TimeInterval = 0, action:@escaping buttonClick) {
        addTarget(self, action:#selector(tapped(button:)) , for:.touchUpInside)
        self.delay = delay
        actionBlock = action
    }
}
