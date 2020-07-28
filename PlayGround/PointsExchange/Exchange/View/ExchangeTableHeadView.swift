//
//  ExchangeTableHeadView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/28.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeTableHeadView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Property
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "中华皮肤科杂志电子版激活码（年）"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.medium(18)
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
    
    lazy var chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "选择兑换期刊"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.regular(17)
        return label
    }()
    
    lazy var chooseLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE3E8FF)
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var chooseBtn: ChooseView = {
        let view = ChooseView()
        view.clickAction = { () in
//            UIApplication.shared.windows[0].addSubview(self.selectView)
//            self.selectView.snp.makeConstraints { (make) in
//                make.edges.equalToSuperview()
//            }
        }
        return view
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF7F7F7)
        return view
    }()

    private func setupUI() {
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(requiredPoints)
        addSubview(chooseLine)
        addSubview(chooseLabel)
        addSubview(chooseBtn)
        addSubview(separatorLine)
        
        coverImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kScreenWidth * 0.5333)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.bottom).offset(20.5)
            make.left.equalToSuperview().offset(15)
        }
        requiredPoints.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
        }
        chooseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(requiredPoints.snp.bottom).offset(20.5)
            make.left.equalTo(requiredPoints)
        }
        chooseLine.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(chooseLabel)
            make.size.equalTo(CGSize(width: 110, height: 7.5))
        }
        chooseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(chooseLabel.snp.bottom).offset(14.5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(45)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.top.equalTo(chooseBtn.snp.bottom).offset(28.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(11.5)
            make.bottom.equalToSuperview()
        }
    }
}
