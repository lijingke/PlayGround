//
//  DenyLoginView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/6.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DenyLoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "您暂时不能进入App哦"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.regular(30)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "1. 您当前未入驻医院，入驻后，才可进入页面操作。\n\n2. 若您有未提现的金额，系统将在下个月10号前汇入您的账户，如有疑问，请联系客服咨询：400-6700-701。"
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x424242)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_bg_img")
        return imageView
    }()
    
    lazy var callBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hex: 0x4C5BF4)
        btn.setTitle("点击拨打：400-6700-701", for: .normal)
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        return btn
    }()
    
}

extension DenyLoginView {
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(callBtn)
        addSubview(bgImage)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(27)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-40)
        }
        callBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(31.5)
            make.left.equalToSuperview().offset(37.5)
            make.right.equalToSuperview().offset(-37.5)
            make.height.equalTo(44)
        }
        bgImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func btnAction() {
        let phone = "telprompt://" + "400-6700-701"
        if let phoneURL = URL(string: phone) {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}
