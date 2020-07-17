//
//  MagazineInstructionCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MagazineInstructionCell: UITableViewCell {
    
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
        label.text = "丘疹性弹性纤维离解22例临床病理分析"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.regular(15)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "李伟；刘洁；杨志钢"
        label.textColor = UIColor(hex: 0xA4A4A4)
        label.font = UIFont.regular(14)
        return label
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xD5D5D5)
        return view
    }()
    
}

// MARK: - UI
extension MagazineInstructionCell {
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(separatorLine)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-12.5)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(separatorLine.snp.top).offset(-11.5)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
