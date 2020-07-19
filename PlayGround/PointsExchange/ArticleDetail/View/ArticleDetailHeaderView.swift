//
//  ArticleDetailHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/19.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ArticleDetailHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Property
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(17)
        label.textColor = UIColor(hex: 0x333333)
        label.numberOfLines = 0
        return label
    }()
}

// MARK: - UI
extension ArticleDetailHeaderView {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-17)
        }
    }
}
