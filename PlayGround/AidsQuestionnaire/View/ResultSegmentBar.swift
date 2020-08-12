//
//  ResultSegmentBar.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/8/12.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

protocol ResultSegmentBarDelegate: NSObject {
    func segmentBarDidSelect(fromIndex: NSInteger)
}

class ResultSegmentBar: UIView {
    
    // MARK: Property
    weak var delegate: ResultSegmentBarDelegate?
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var syphilisBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.setTitle("梅毒知识调查", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x182132), for: .normal)
        btn.titleLabel?.font = UIFont.regular(17)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var aidsBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.setTitle("艾滋病知识调查", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x182132), for: .normal)
        btn.titleLabel?.font = UIFont.regular(17)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var slideLine: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "tab_active")
        return view
    }()
    
    public func setScrollValue(value : CGFloat) {
        let distance = aidsBtn.frame.origin.x - syphilisBtn.frame.origin.x
        
        slideLine.center = CGPoint(x: 15 + 20 + value * distance, y: slideLine.center.y)

        slideLine.setNeedsUpdateConstraints()
        slideLine.updateConstraintsIfNeeded()
        slideLine.needsUpdateConstraints()
        
        if value > 0.5 {
            syphilisBtn.isSelected = false
            aidsBtn.isSelected = true
            aidsBtn.titleLabel?.font = UIFont.medium(20)
            syphilisBtn.titleLabel?.font = UIFont.regular(17)
        } else {
            syphilisBtn.isSelected = true
            aidsBtn.isSelected = false
            aidsBtn.titleLabel?.font = UIFont.regular(17)
            syphilisBtn.titleLabel?.font = UIFont.medium(20)
        }
    }
    
}

// MARK: - UI
extension ResultSegmentBar {
    private func setupUI() {
        backgroundColor = .white
        addSubview(syphilisBtn)
        addSubview(aidsBtn)
        addSubview(slideLine)
        addSubview(bottomLine)
        
        syphilisBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(bottomLine.snp.top)
        }
        aidsBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(syphilisBtn)
            make.left.equalTo(syphilisBtn.snp.right).offset(26)
        }
        
        // 避免滑动时造成setFrame与Autolayout冲突
        let originY: CGFloat = 45 - 2 - 0.5
        slideLine.frame = CGRect(x: 15, y: originY, width: 40, height: 10)
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - Event
extension ResultSegmentBar {
    @objc private func btnAction(sender: UIButton) {
        delegate?.segmentBarDidSelect(fromIndex: sender.tag)
    }
}
