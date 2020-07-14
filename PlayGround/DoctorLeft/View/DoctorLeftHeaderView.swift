//
//  DoctorLeftHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorLeftHeaderView: UIView {
    
    // MARK: Lift Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty_nodata")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "该医生已离开该医院"
        label.font = UIFont.semibold(17)
        label.textColor = UIColor(hex: 0x28354C, alpha: 0.5)
        return label
    }()
}

// MARK: - UI
extension DoctorLeftHeaderView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(bgImageView)
        addSubview(titleLabel)
        bgImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-24)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView.snp.bottom)
            make.centerX.equalTo(bgImageView)
        }
    }
}
