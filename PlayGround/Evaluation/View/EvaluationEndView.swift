//
//  EvaluationEndView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class EvaluationEndView: UIView {
    
    weak var delegate: EvaluationEndViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    lazy var hintBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "答题结束"
        label.font = UIFont.medium(20)
        label.textColor = UIColor(hex: 0x333333)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "您的用时已超过20分钟，无法继续答题"
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x747474)
        return label
    }()
    
    lazy var hintImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "end")
        return view
    }()
    
    lazy var resultBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("查看结果", for: .normal)
        btn.backgroundColor = UIColor(hex: 0x4E61FB)
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(resultBtnAction(sender:)), for: .touchUpInside)
        return btn
    }()
}

extension EvaluationEndView {
    @objc private func resultBtnAction(sender: UIButton) {
        self.hide()
        delegate?.jumpToResult()
    }
}

extension EvaluationEndView {
    
    private func setupUI() {
        self.isHidden = true
        addSubview(bgView)
        self.addSubview(hintBgView)
        hintBgView.addSubview(titleLabel)
        hintBgView.addSubview(contentLabel)
        hintBgView.addSubview(hintImageView)
        hintBgView.addSubview(resultBtn)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        hintBgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(hintBgView.snp.width).multipliedBy(0.89)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(29)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(13.5)
        }
        hintImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        resultBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(37)
            make.right.equalToSuperview().offset(-37)
            make.bottom.equalToSuperview().offset(-29)
            make.height.equalTo(50)
        }
    }
    
    public func show() {
      self.isHidden = false
    }
    
    public func hide() {
        self.isHidden = true
    }

}
