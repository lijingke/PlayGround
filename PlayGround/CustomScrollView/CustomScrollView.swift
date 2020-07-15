//
//  CustomScrollView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/15.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class CustomScrollView: UIView {
    
    // MARK: Property
    var contentSize: CGSize = .zero
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        /// 相对于初始位置的偏移量
        let translation = gestureRecognizer.translation(in: self)
        var bounds = self.bounds
        
        print(translation)
        
        let newBoundsOriginX = bounds.origin.x - translation.x
        let minBoundsOriginX: CGFloat = 0.0
        let maxBoundsOriginX = self.contentSize.width - bounds.size.width
        bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX))
        
        let newBoundsOriginY = bounds.origin.y - translation.y
        let minBoundsOriginY: CGFloat = 0.0
        let maxBoundsOriginY = self.contentSize.height - bounds.size.height
        bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY))
        
        print(bounds)
        self.bounds = bounds
        gestureRecognizer.setTranslation(.zero, in: self)
        
    }
}

