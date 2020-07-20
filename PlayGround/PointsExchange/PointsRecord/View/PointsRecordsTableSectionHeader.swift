//
//  PointsRecordsTableSectionHeader.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsTableSectionHeader: UITableViewHeaderFooterView {
    
    struct RecordHeaderEntity {
        var isOpen = true
        var section: Int = 0
        var time: String?
    }
    
    // MARK: Property
    private var entity: RecordHeaderEntity = RecordHeaderEntity()
    
    public var openBlock: ((Int)->())?
    public var closeBlock: ((Int)->())?
    
    // MARK:  Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2019年3月"
        label.font = UIFont.medium(17)
        label.textColor = UIColor(hex: 0x7D7D7D)
        return label
    }()
    
    lazy var foldBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "unfold"), for: .normal)
        btn.addTarget(self, action: #selector(self.tapAction), for: .touchUpInside)
        return btn
    }()
}

extension PointsRecordsTableSectionHeader {
    @objc private func tapAction() {
        if entity.isOpen {
            UIView.animate(withDuration: 0.3) {
                self.foldBtn.transform = self.foldBtn.transform.rotated(by: -.pi / 2)
            }
            closeBlock?(entity.section)
        } else {
            UIView.animate(withDuration: 0.3) {
                self.foldBtn.transform = self.foldBtn.transform.rotated(by: .pi / 2)
            }
            openBlock?(entity.section)
        }
        entity.isOpen.toggle()
    }
}

// MARK: - UI
extension PointsRecordsTableSectionHeader {
    private func setupUI() {
        contentView.addSubview(foldBtn)
        contentView.addSubview(timeLabel)

        foldBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 37, height: 37))
        }
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(foldBtn)
            make.left.equalTo(foldBtn.snp.right)
        }
    }
}

// MARK: - Data
extension PointsRecordsTableSectionHeader {
    
    public func setupData(entity: RecordHeaderEntity) {
        self.entity = entity
        timeLabel.text = entity.time
        self.foldBtn.transform = CGAffineTransform.identity

        if entity.isOpen {
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.foldBtn.transform = self.foldBtn.transform.rotated(by: -.pi / 2)
            }
        }
        
    }
}
