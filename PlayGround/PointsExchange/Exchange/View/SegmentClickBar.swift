//
//  SegmentClickBar.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/28.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

protocol SegmentClickBarDelegate: NSObject {
    func segmentBarDidSelect(toIndex: Int)
}

class SegmentClickBar: UIView {
    
    // MARK: Property
    weak var delegate: SegmentClickBarDelegate?
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
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
    
}

// MARK: - UI
extension SegmentClickBar {
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
            make.centerX.equalTo(instructionsBtn)
            make.bottom.equalTo(bottomLine.snp.top)
            make.size.equalTo(CGSize(width: 90, height: 2))
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - Event
extension SegmentClickBar {
    @objc private func btnAction(sender: UIButton) {
        for subview in subviews {
            if subview.isKind(of: UIButton.self) {
                let btn = subview as! UIButton
                btn.isSelected = false
                if subview == sender {
                    btn.isSelected = true
                    btn.titleLabel?.font = UIFont.medium(17)
                    slideLine.snp.remakeConstraints { (make) in
                        make.centerX.equalTo(sender)
                        make.bottom.equalTo(bottomLine.snp.top)
                        make.size.equalTo(CGSize(width: 90, height: 2))
                    }
                    
                } else {
                    btn.titleLabel?.font = UIFont.regular(17)
                }
            }
        }
        
        delegate?.segmentBarDidSelect(toIndex: sender.tag)
    }
}
