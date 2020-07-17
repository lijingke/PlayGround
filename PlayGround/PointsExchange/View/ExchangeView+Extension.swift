//
//  ExchangeView+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

// MARK: - ChooseView
extension ExchangeView {
    
    class ChooseView: UIView {
        
        public var clickAction: (()->())?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "2019年全年"
            label.font = UIFont.regular(17)
            label.textColor = UIColor(hex: 0x5161F9)
            return label
        }()
        
        lazy var chooseImg: UIButton = {
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named: "more_blue"), for: .normal)
            return btn
        }()
        
        private func setupUI() {
            backgroundColor = UIColor(hex: 0xF3F5FF)
            layer.borderColor = UIColor(hex: 0x5161F9).cgColor
            layer.borderWidth = 0.5
            layer.cornerRadius = 5
            addSubview(titleLabel)
            addSubview(chooseImg)
            titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(16.5)
            }
            chooseImg.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-16)
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
            addGestureRecognizer(tap)
        }
        
        @objc private func tapAction() {
            clickAction?()
        }
    }
}
