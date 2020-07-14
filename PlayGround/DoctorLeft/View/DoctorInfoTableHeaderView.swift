//
//  DoctorInfoTableHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorInfoTableHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "DoctorInfoTableHeaderView"
    
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
        label.font = UIFont.medium(16)
        label.text = "为您推荐其他医生"
        label.textColor = UIColor(hex: 0x182132)
        return label
    }()

}

// MARK: - UI
extension DoctorInfoTableHeaderView {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
