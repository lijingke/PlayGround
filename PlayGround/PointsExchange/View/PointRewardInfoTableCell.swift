//
//  PointRewardInfoTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointRewardInfoTableCell: UITableViewCell {
    
    // MARK: Lift Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        coverImgView.addCorner(conrners: [.topLeft, .bottomLeft], radius: 10)
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
    
    lazy var coverImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img2")
        return view
    }()
    
    lazy var exchangeTimesBg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mark")
        return view
    }()
    
    lazy var exchangeTimes: UILabel = {
        let label = UILabel()
        label.text = "已兑换：213 人次"
        label.textColor = .white
        label.font = UIFont.regular(13)
        return label
    }()
    
    lazy var goodsName: UILabel = {
        let label = UILabel()
        label.text = "中华皮肤科杂志电子版激活码（年）"
        label.textColor = UIColor(hex: 0x33333)
        label.font = UIFont.regular(17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var requiredPoints: UILabel = {
        let label = UILabel()
        label.text = "3000积分"
        label.textColor = UIColor(hex: 0xF0A044)
        label.font = UIFont.regular(17)
        return label
    }()
    
    lazy var exchangeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hex: 0xFFF5E4)
        btn.setTitle("兑换", for: .normal)
        btn.setTitleColor(UIColor(hex: 0xEF8E24), for: .normal)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.layer.cornerRadius = 17
        return btn
    }()
}

// MARK: - UI
extension PointRewardInfoTableCell {
    
    private func setupUI() {
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12.5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-12.5)
            make.height.equalTo(132)
        }
        bgView.addSubview(coverImgView)
        bgView.addSubview(exchangeTimesBg)
        exchangeTimesBg.addSubview(exchangeTimes)
        bgView.addSubview(goodsName)
        bgView.addSubview(requiredPoints)
        bgView.addSubview(exchangeBtn)
        coverImgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 98.25, height: 132))
        }
        exchangeTimesBg.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
        }
        exchangeTimes.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        goodsName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(34.5)
            make.left.equalTo(coverImgView.snp.right).offset(10.5)
            make.right.equalToSuperview().offset(-31.5)
        }
        requiredPoints.snp.makeConstraints { (make) in
            make.top.equalTo(goodsName.snp.bottom)
            make.left.equalTo(goodsName)
        }
        exchangeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(requiredPoints)
            make.right.equalToSuperview().offset(-7)
            make.size.equalTo(CGSize(width: 85, height: 34))
        }
        
        coverImgView.setNeedsLayout()
        coverImgView.layoutIfNeeded()

    }
    
}
