//
//  DoctorInfoTableFooterView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorInfoTableFooterView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "DoctorInfoTableFooterView"
    
    // MARK:  Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var moreBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("咨询其他医生", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: 0xFF7056)
        btn.titleLabel?.font = UIFont.medium(18)
        btn.layer.cornerRadius = 25
        return btn
    }()
}

// MARK: - UI
extension DoctorInfoTableFooterView {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
