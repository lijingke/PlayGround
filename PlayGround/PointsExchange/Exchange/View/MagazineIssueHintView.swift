//
//  MagazineIssueHintView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MagazineIssueHintView: UIView {
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(1)
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x4E61FB), for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x4E61FB), for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
}

// MARK: - UI
extension MagazineIssueHintView {
    private func setupUI() {
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Event
extension MagazineIssueHintView {
    @objc private func btnAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("取消")
            break
        case 1:
            print("确定")
            break
        default:
            break
        }
    }
}
