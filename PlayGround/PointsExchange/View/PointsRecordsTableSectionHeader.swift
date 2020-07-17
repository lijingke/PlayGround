//
//  PointsRecordsTableSectionHeader.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsTableSectionHeader: UITableViewHeaderFooterView {
    
    // MARK:  Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2019年3月"
        label.font = UIFont.medium(17)
        label.textColor = UIColor(hex: 0x7D7D7D)
        return label
    }()
    
    lazy var foldBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "up"), for: .normal)
        return btn
    }()
}

// MARK: - UI
extension PointsRecordsTableSectionHeader {
    private func setupUI() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(foldBtn)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(31)
        }
        foldBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel)
            make.right.equalToSuperview().offset(-33.5)
            make.size.equalTo(CGSize(width: 18, height: 10))
        }
    }
}
