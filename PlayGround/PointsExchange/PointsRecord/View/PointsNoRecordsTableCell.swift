//
//  PointsNoRecordsTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/20.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsNoRecordsTableCell: UITableViewCell {
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "该月暂无积分明细"
        label.font = UIFont.medium(14)
        label.textColor = UIColor(hex: 0xCACBCC)
        return label
    }()
}

extension PointsNoRecordsTableCell {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
}
