//
//  ArticleDetailTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/19.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ArticleDetailTableCell: UITableViewCell {
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x7E7E7E)
        return label
    }()
    
    lazy var contentLabel: UILabel = {let label = UILabel()
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x7E7E7E)
        label.numberOfLines = 0
        return label
    }()
}

// MARK: - Data
extension ArticleDetailTableCell {
    public func setupData(title: String?, content: String?) {
        titleLabel.text = title
        contentLabel.text = content
    }
}

// MARK: - UI
extension ArticleDetailTableCell {
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(107)
            
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalToSuperview().offset(-15.5)
            make.bottom.equalToSuperview().offset(-8)}
    }
}
