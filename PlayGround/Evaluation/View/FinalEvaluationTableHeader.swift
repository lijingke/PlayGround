//
//  FinalEvaluationTableHeader.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/22.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationTableHeader: UIView {
    
    enum BtnType {
        case hide
        case comfirm
        case next
        case end
    }
    
    // MARK: - Property
    public var btnActionBlock: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
        
    lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hex: 0x4E61FB)
        btn.titleLabel?.font = UIFont.regular(15)
        btn.setTitle("确定", for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(btnDidClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "题目"
        label.font = UIFont.semibold(19)
        label.textColor = UIColor(hex: 0x333333)
        return label
    }()
    
    lazy var separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xDCDCDC)
        return view
    }()
}

extension FinalEvaluationTableHeader {
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(confirmBtn)
        contentView.addSubview(separateLine)
        contentView.snp.makeConstraints { (make) in
               make.edges.equalToSuperview()
               make.height.equalTo(65)
           }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20.5)
        }
        confirmBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-18.5)
            make.size.equalTo(CGSize(width: 81, height: 31))
        }
        separateLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        clipsToBounds = true
    }
    
    public func setupData(title: String, btnType: BtnType) {
        titleLabel.text = title
        switch btnType {
        case .hide:
            break
        case .comfirm:
            confirmBtn.setTitle("确定", for: .normal)
        case .next:
            confirmBtn.setTitle("下一题", for: .normal)
        case .end:
            confirmBtn.setTitle("完成", for: .normal)
        }
        confirmBtn.isHidden = btnType == .hide
    }
    
    @objc private func btnDidClicked(_ sender: UIButton) {
        btnActionBlock?()
    }
}
