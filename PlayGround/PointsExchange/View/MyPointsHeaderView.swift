//
//  MyPointsHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MyPointsHeaderView: UITableViewHeaderFooterView {
    
    private var scrollArray: [String] = ["AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "BBBBBB", "CCCCCC"]
    
    // MARK: Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "积分兑换"
        label.font = UIFont.medium(17)
        label.textColor = UIColor(hex: 0x333333)
        return label
    }()
    
    lazy var indicator: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("动态", for: .normal)
        btn.setTitleColor(UIColor(hex: 0x5662F8), for: .normal)
        btn.titleLabel?.font = UIFont.medium(12)
        btn.layer.borderColor = UIColor(hex: 0x5662F8).cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        btn.isEnabled = false
        return btn
    }()
    
    lazy var scrollText: LMJVerticalScrollText = {
        let width = UIScreen.main.bounds.width - 66.5
        let view = LMJVerticalScrollText(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        view.textDataArr = self.scrollArray
        view.textStayTime = 1
        view.scrollAnimationTime = 1
        view.textColor = UIColor(hex: 0x7E7E7E)
        view.textFont = UIFont.regular(15)        
        return view
    }()
    
}

// MARK: - UI
extension MyPointsHeaderView {
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(indicator)
        contentView.addSubview(scrollText)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
        }
        indicator.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(14.75)
            make.left.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 37.5, height: 17))
            make.bottom.equalToSuperview().offset(-9.5)
        }
        scrollText.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(indicator)
            make.left.equalTo(indicator.snp.right).offset(8.25)
            make.right.equalToSuperview().offset(-13.25)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollText.startScrollBottomToTopWithNoSpace()
    }
}
