//
//  PointsRecordsTableHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsTableHeaderView: UIView {
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var indicatorView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_subtitle")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "积分明细"
        label.textColor = UIColor(hex: 0x3C3C3C)
        label.font = UIFont.medium(16)
        return label
    }()
}

// MARK: - UI
extension PointsRecordsTableHeaderView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(indicatorView)
        addSubview(titleLabel)
        indicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-24.5)
            make.size.equalTo(CGSize(width: 3, height: 15))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(indicatorView)
            make.left.equalTo(indicatorView.snp.right).offset(8)
        }
    }
}
