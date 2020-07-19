//
//  ExchangeRecordsTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeRecordsTableCell: UITableViewCell {
        
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var coverImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img3")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "中华皮肤科杂志电子版激活码（年）"
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x333333)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var exchangeTime: UILabel = {
        let label = UILabel()
        label.text = "兑换日期：2020-6-20"
        label.font = UIFont.regular(14)
        label.textColor = UIColor(hex: 0xA4A4A4)
        return label
    }()
    
    lazy var spendPoints: UILabel = {
        let label = UILabel()
        label.text = "使用积分：10000"
        label.font = UIFont.regular(14)
        label.textColor = UIColor(hex: 0xA4A4A4)
        return label
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xD5D5D5)
        return view
    }()
    
    lazy var activationCode: UILabel = {
        let label = UILabel()
        label.text = "激活码：200618qGjd"
        label.font = UIFont.regular(17)
        label.textColor = UIColor(hex: 0x333333)
        return label
    }()
    
    lazy var copyBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("  复制", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x5161F9), for: .normal)
        btn.titleLabel?.font = UIFont.regular(16)
        btn.setImage(UIImage(named: "copy"), for: .normal)
        btn.addTarget(self, action: #selector(self.copyAction), for: .touchUpInside)
        return btn
    }()
}

// MARK: - Event
extension ExchangeRecordsTableCell {
    @objc private func copyAction() {
        UIPasteboard.general.string = activationCode.text
        Loading.showToastOnSuccess(with: "复制成功", to: UIApplication.shared.windows[0])
    }
}

// MARK: - UI
extension ExchangeRecordsTableCell {
    
    private func setupUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(coverImg)
        bgView.addSubview(titleLabel)
        bgView.addSubview(exchangeTime)
        bgView.addSubview(spendPoints)
        bgView.addSubview(separatorLine)
        bgView.addSubview(activationCode)
        bgView.addSubview(copyBtn)
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-17)
            make.height.equalTo(177)
        }
        coverImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17.5)
            make.left.equalToSuperview().offset(13.5)
            make.size.equalTo(CGSize(width: 89, height: 89))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImg)
            make.left.equalTo(coverImg.snp.right).offset(15)
            make.right.equalToSuperview().offset(-35)
        }
        exchangeTime.snp.makeConstraints { (make) in
            make.left.equalTo(spendPoints)
            make.bottom.equalTo(spendPoints.snp.top)
        }
        spendPoints.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(coverImg)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(coverImg.snp.bottom).offset(17.25)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        activationCode.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(13.75)
            make.left.equalToSuperview().offset(13.5)
        }
        copyBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(activationCode)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
}
