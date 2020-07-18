//
//  PointsRecordsTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsTableCell: UITableViewCell {
    
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
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "积分兑换"
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x3C3C3C)
        return label
    }()
    
    lazy var creatTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2019-03-18 07:13"
        label.font = UIFont.medium(14)
        label.textColor = UIColor(hex: 0xCACBCC)
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "+15"
        label.font = UIFont.medium(24)
        label.textColor = UIColor(hex: 0xFC9600)
        return label
    }()

    lazy var septateLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(hex: 0xF2F3F5)
        return line
    }()
    
}

// MARK: - UI
extension PointsRecordsTableCell {
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(creatTimeLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(septateLine)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(31)
        }
        creatTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
        }
        countLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.right.equalToSuperview().offset(-34.5)
        }
        septateLine.snp.makeConstraints { (make) in
            make.top.equalTo(creatTimeLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(1)
        }
    }
}

// MARK: - Data
extension PointsRecordsTableCell {
    public func setupData(_ data: MonthlyPointsEntity.PointsChangeEntity) {
        titleLabel.text = data.title
        creatTimeLabel.text = data.changeTime
        if let points = data.count {
            countLabel.text = "\(points)"
            titleLabel.textColor = points > 0 ? UIColor(hex: 0x3C3C3C) : UIColor(hex: 0x5161F9)
            countLabel.textColor = points > 0 ? UIColor(hex: 0xFC9600) : UIColor(hex: 0xB4B4B4)
        }
    }
}
