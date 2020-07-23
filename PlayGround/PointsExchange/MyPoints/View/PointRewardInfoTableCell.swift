//
//  PointRewardInfoTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit
import SDWebImage

class PointRewardInfoTableCell: UITableViewCell {
    
    // MARK: Property
    private var magazineInfo: MagazineInfoEntity?
    
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

// MARK: - Data
extension PointRewardInfoTableCell {
    public func setupData(magazine: MagazineInfoEntity) {
        coverImgView.sd_setImage(with: URL(string: magazine.coverURL ?? ""), placeholderImage: UIImage(named: "img2"))
        
        let attribute = NSMutableAttributedString()
        let titleName = NSMutableAttributedString(string: magazine.magazineTitle ?? "")
        titleName.addAttributes([.font: UIFont.regular(17)!, .foregroundColor: UIColor(hex: 0x33333)], range: NSRange(location: 0, length: titleName.length))
        attribute.append(titleName)
        let priceString = NSMutableAttributedString(string: "¥250")
        priceString.addAttributes([.strikethroughStyle: 1, .font: UIFont.regular(15)!, .foregroundColor: UIColor(hex: 0x9A9C9F)], range: NSRange(location: 0, length: priceString.length))
        attribute.append(priceString)
        goodsName.attributedText = attribute
        
        requiredPoints.text = "\(magazine.needPoints ?? 0)积分"
        if let num = magazine.exchangeNum, num > 0 {
            exchangeTimes.text = "已兑换：\(num) 人次"
            exchangeTimesBg.isHidden = false
        } else {
            exchangeTimesBg.isHidden = true
        }
        
    }
}

// MARK: - UI
extension PointRewardInfoTableCell {
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
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
