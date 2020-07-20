//
//  SegmentBar.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/18.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

protocol SegmentBarDelegate: NSObject {
    func segmentBarDidSelect(fromIndex: NSInteger)
}

class SegmentBar: UIView {
    
    // MARK: Property
    weak var delegate: SegmentBarDelegate?
    
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
    
    public func setScrollValue(value : CGFloat) {
        let distance = previewBtn.center.x - instructionsBtn.center.x
        let centerX = instructionsBtn.center.x
        //        slideLine.center.x = centerX + value * distance
        slideLine.center = CGPoint(x: centerX + value * distance, y: slideLine.center.y)
        
        slideLine.setNeedsUpdateConstraints()
        slideLine.updateConstraintsIfNeeded()
        slideLine.needsUpdateConstraints()
        
        if value > 0.5 {
            instructionsBtn.isSelected = false
            previewBtn.isSelected = true
            previewBtn.titleLabel?.font = UIFont.medium(17)
            instructionsBtn.titleLabel?.font = UIFont.regular(17)
        } else {
            instructionsBtn.isSelected = true
            previewBtn.isSelected = false
            previewBtn.titleLabel?.font = UIFont.regular(17)
            instructionsBtn.titleLabel?.font = UIFont.medium(17)
        }
    }
    
}

// MARK: - UI
extension SegmentBar {
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
        //        slideLine.snp.makeConstraints { (make) in
        //            make.centerX.equalTo(instructionsBtn)
        //            make.bottom.equalTo(bottomLine.snp.top)
        //            make.size.equalTo(CGSize(width: 90, height: 2))
        //        }
        
        // 避免滑动时造成setFrame与Autolayout冲突
        let originX = (kScreenWidth / 2 - 90) / 2
        let originY: CGFloat = 45 - 2 - 0.5
        slideLine.frame = CGRect(x: originX, y: originY, width: 90, height: 2)
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - Event
extension SegmentBar {
    @objc private func btnAction(sender: UIButton) {
        delegate?.segmentBarDidSelect(fromIndex: sender.tag)
    }
}
