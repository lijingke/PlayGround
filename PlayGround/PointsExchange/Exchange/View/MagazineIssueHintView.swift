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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "兑换确认"
        label.font = UIFont.medium(18)
        label.textColor = UIColor(hex: 0x333333)
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "是否确认兑换「2019年第一期」电子激活码？"
        label.font = UIFont.regular(15)
        label.textColor = UIColor(hex: 0x333333)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "兑换成功后，可去【兑换记录】里查看"
        label.font = UIFont.regular(14)
        label.textColor = UIColor(hex: 0x747474)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x5161F9), for: .normal)
        btn.titleLabel?.font = UIFont.regular(18)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x5161F9), for: .normal)
        btn.titleLabel?.font = UIFont.semibold(18)
        btn.addTarget(self, action: #selector(self.btnAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var horizontalSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE5E5E5)
        return view
    }()
    
    lazy var verticalSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE5E5E5)
        return view
    }()
}

// MARK: - UI
extension MagazineIssueHintView {
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(tipsLabel)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(confirmButton)
        contentView.addSubview(horizontalSeparatorLine)
        contentView.addSubview(verticalSeparatorLine)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(29)
            make.centerX.equalToSuperview()
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        horizontalSeparatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(19)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(horizontalSeparatorLine.snp.bottom)
            make.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(50)
        }
        confirmButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.size.equalTo(cancelBtn)
        }
        
        verticalSeparatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(horizontalSeparatorLine.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(0.5)
        }
    }
}

// MARK: - Event
extension MagazineIssueHintView {
    @objc private func btnAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            print("取消")
            removeFromSuperview()
            break
        case 1:
            print("确定")
            break
        default:
            break
        }
    }
}
