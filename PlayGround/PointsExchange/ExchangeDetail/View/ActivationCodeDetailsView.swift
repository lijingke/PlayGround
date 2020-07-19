//
//  ActivationCodeDetailsView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

class ActivationCodeDetailsView: UIView {
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    
    lazy var activationCode: UILabel = {
        let label = UILabel()
        label.text = "激活码：200618qGjd"
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x333333)
        return label
    }()
    
    lazy var exchangeTime: UILabel = {
        let label = UILabel()
        label.text = "兑换日期：2020-6-20"
        label.font = UIFont.regular(15)
        label.textColor = UIColor(hex: 0xA4A4A4)
        return label
    }()
    
    lazy var spendPoints: UILabel = {
        let label = UILabel()
        label.text = "使用积分：10000"
        label.font = UIFont.regular(15)
        label.textColor = UIColor(hex: 0xA4A4A4)
        return label
    }()
    
    lazy var copyBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("一键复制", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.backgroundColor = UIColor(hex: 0x5161F9)
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(self.copyAction), for: .touchUpInside)
        return btn
    }()
    
}

// MARK: Event
extension ActivationCodeDetailsView {
    @objc private func copyAction() {
        UIPasteboard.general.string = activationCode.text
        Loading.showToastOnSuccess(with: "复制成功", to: UIApplication.shared.windows[0])
    }
}

// MARK: - UI
extension ActivationCodeDetailsView {
    private func setupUI() {
        backgroundColor = UIColor(hex: 0xF3F5FF)
        addSubview(activationCode)
        addSubview(exchangeTime)
        addSubview(spendPoints)
        addSubview(copyBtn)
        activationCode.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(13.5)
            make.left.equalToSuperview().offset(16.5)
        }
        exchangeTime.snp.makeConstraints { (make) in
            make.top.equalTo(activationCode.snp.bottom).offset(2)
            make.left.equalTo(activationCode)
        }
        spendPoints.snp.makeConstraints { (make) in
            make.top.equalTo(exchangeTime.snp.bottom).offset(2)
            make.left.equalTo(exchangeTime)
            make.bottom.equalToSuperview().offset(-14)
        }
        copyBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(21.5)
            make.right.equalToSuperview().offset(-12.5)
            make.size.equalTo(CGSize(width: 89, height: 32))
        }
    }
}
