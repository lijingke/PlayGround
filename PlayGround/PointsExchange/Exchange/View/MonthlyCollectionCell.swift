//
//  MonthlyCollectionCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MonthlyCollectionCell: UICollectionViewCell {
    
    // MARK: Property
    static let identifier = "MonthlyCollectionCell"
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "1期"
        label.font = UIFont.regular(15)
        label.textColor = UIColor(hex: 0x7E7E7E)
        return label
    }()
}

// MARK: - UI
extension MonthlyCollectionCell {
    private func setupUI() {
        backgroundColor = UIColor(hex: 0xF7F7F7)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
