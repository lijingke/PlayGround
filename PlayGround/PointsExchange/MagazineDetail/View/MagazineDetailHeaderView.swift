//
//  MagazineDetailHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MagazineDetailHeaderView: UITableViewHeaderFooterView {
    
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
        label.text = "重组人II型肿瘤坏死因子受体-抗体融合蛋白治疗中毒性表皮坏死松懈症的临床疗效观察"
        label.font = UIFont.medium(17)
        label.textColor = UIColor(hex: 0x333333)
        label.numberOfLines = 0
        return label
    }()
}

// MARK: - UI
extension MagazineDetailHeaderView {
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
