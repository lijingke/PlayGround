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
    
    class SegmentBar: UIView {
        
        // MARK: Life Cycle
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        lazy var instructionsBtn: UIButton = {
            let btn = UIButton(type: .custom)
            btn.tag = 0
            btn.setTitle("兑换说明", for: .normal)
            btn.setTitleColor(UIColor(hex: 0x333333), for: .normal)
            btn.titleLabel?.font = UIFont.regular(17)
            btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
            return btn
        }()
        
        lazy var previewBtn: UIButton = {
            let btn = UIButton(type: .custom)
            btn.tag = 1
            btn.setTitle("过刊预览", for: .normal)
            btn.setTitleColor(UIColor(hex: 0x333333), for: .normal)
            btn.titleLabel?.font = UIFont.regular(17)
            btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
            return btn
        }()
        
        lazy var bottomLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hex: 0xD5D5D5)
            return view
        }()
        
        lazy var slideLine: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hex: 0xEF9018)
            return view
        }()
        
        private func setupUI() {
            backgroundColor = .white
            addSubview(instructionsBtn)
            addSubview(previewBtn)
            addSubview(slideLine)
            addSubview(bottomLine)
            instructionsBtn.snp.makeConstraints { (make) in
                make.top.left.equalToSuperview()
                make.bottom.equalTo(bottomLine.snp.top)
                make.width.equalToSuperview().multipliedBy(0.5)
            }
            previewBtn.snp.makeConstraints { (make) in
                make.top.right.equalToSuperview()
                make.bottom.width.equalTo(instructionsBtn)
            }
            slideLine.snp.makeConstraints { (make) in
                make.centerX.equalTo(instructionsBtn).offset(0)
                make.bottom.equalTo(bottomLine.snp.top)
                make.size.equalTo(CGSize(width: 90, height: 2))
            }
            bottomLine.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalTo(0.5)
            }
        }
        
        @objc private func btnAction(sender: UIButton) {
            for subview in subviews {
                if subview.isKind(of: UIButton.self) {
                    let btn = subview as! UIButton
                    btn.isSelected = false
                    if subview == sender {
                        btn.isSelected = true
                        btn.titleLabel?.font = UIFont.medium(17)

                        UIView.animate(withDuration: 0.2) {
                            self.slideLine.center.x = subview.center.x
                            self.slideLine.setNeedsLayout()
                            self.slideLine.layoutIfNeeded()
                        }
         
                    } else {
                        btn.titleLabel?.font = UIFont.regular(17)
                    }
                }
            }
        }
        
    }
}
