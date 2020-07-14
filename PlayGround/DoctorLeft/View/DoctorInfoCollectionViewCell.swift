//
//  DoctorInfoCollectionViewCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorInfoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DoctorInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        /// 偏移距离
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        /// 不透明度
        view.layer.shadowOpacity = 1
        /// 半径
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var doctorAvatar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "doctor_default_80")
        return view
    }()
    
    lazy var doctorTitleDecorate: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "doctor_title")
        return view
    }()
    
    lazy var doctorTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(11)
        label.text = "副主任医师"
        label.textColor = .white
        return label
    }()
    
    lazy var doctorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(17)
        label.text = "Wheel"
        label.textColor = UIColor(hex: 0x0C1832)
        return label
    }()
    
    lazy var doctorDepartment: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(14)
        label.text = "内江市 东兴区"
        label.textColor = UIColor(hex: 0x28354C)
        return label
    }()
    
    lazy var goodAt: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(12)
        label.text = "擅长: 治疗恐艾心理疏导，艾滋病、慢性治疗恐艾心理…"
        label.textColor = UIColor(hex: 0x939AA9)
        label.numberOfLines = 2
        return label
    }()
    
}

// MARK: - UI
extension DoctorInfoCollectionViewCell {
    private func setupUI() {

        contentView.addSubview(bgView)
        bgView.addSubview(doctorAvatar)
        bgView.addSubview(doctorTitleDecorate)
        bgView.addSubview(doctorTitle)
        bgView.addSubview(doctorName)
        bgView.addSubview(doctorDepartment)
        bgView.addSubview(goodAt)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        doctorAvatar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8.5)
            make.left.equalToSuperview().offset(17)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        doctorTitleDecorate.snp.makeConstraints { (make) in
          make.centerX.equalTo(doctorAvatar)
          make.top.equalTo(doctorAvatar.snp.bottom).offset(-5)
        }
        doctorTitle.snp.makeConstraints { (make) in
          make.top.equalTo(doctorTitleDecorate)
          make.centerX.equalTo(doctorTitleDecorate)
        }
        doctorName.snp.makeConstraints { (make) in
            make.top.equalTo(doctorAvatar)
            make.left.equalTo(doctorAvatar.snp.right).offset(19.5)
        }
        doctorDepartment.snp.makeConstraints { (make) in
            make.top.equalTo(doctorName.snp.bottom)
            make.left.equalTo(doctorName)
        }
        goodAt.snp.makeConstraints { (make) in
            make.top.equalTo(doctorDepartment.snp.bottom).offset(4)
            make.left.equalTo(doctorDepartment)
            make.right.lessThanOrEqualToSuperview().offset(-8)
        }
        
    }
}
