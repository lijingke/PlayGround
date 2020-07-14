//
//  FinalEvaluationJudgeAnswerView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationJudgeAnswerView: UIView {
    
    // MARK: Property
    private var entity: QuestionEntity.AnswerEntity?
    public var clickBlock: ((QuestionEntity.AnswerEntity)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF9F9F9)
        view.layer.borderColor = UIColor(hex: 0xCDCDCD).cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(17)
        label.textColor = UIColor(hex: 0x747474)
        label.text = "正确"
        return label
    }()
    
    lazy var statusImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "right")
        view.isHidden = true
        return view
    }()
    
    lazy var judgeIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "radio_default")
        return view
    }()
    
}

extension FinalEvaluationJudgeAnswerView {
    
    @objc func didClicked() {
        if entity?.status == .some(.defult) {
            self.entity?.status = .selected
            clickBlock?(self.entity ?? QuestionEntity.AnswerEntity())
        }
    }
    
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(judgeIcon)
        bgView.addSubview(contentLabel)
        bgView.addSubview(statusImage)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        judgeIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(14.5)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(judgeIcon)
            make.top.equalToSuperview().offset(13)
            make.left.equalTo(judgeIcon.snp.right).offset(9.5)
            make.right.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview().offset(-13)
        }
        statusImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentLabel)
            make.right.equalToSuperview().offset(-17.25)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(didClicked))
        bgView.addGestureRecognizer(tapAction)
    }
    
    public func setupData(entity: QuestionEntity.AnswerEntity) {
        self.entity = entity
        contentLabel.text = entity.title
        switch entity.status {
        case .defult:
            bgView.backgroundColor = UIColor(hex: 0xF9F9F9)
            bgView.layer.borderColor = UIColor(hex: 0xCDCDCD).cgColor
            bgView.layer.borderWidth = 0.5
            contentLabel.textColor = UIColor(hex: 0x747474)
            judgeIcon.image = UIImage(named: "radio_default")
            statusImage.isHidden = true
            break
        case .selected:
            bgView.backgroundColor = UIColor(hex: 0xF9F9F9)
            bgView.layer.borderColor = UIColor(hex: 0x5062FA).cgColor
            bgView.layer.borderWidth = 0.5
            contentLabel.textColor = UIColor(hex: 0x5262FA)
            judgeIcon.image = UIImage(named: "radio_selected")
            statusImage.isHidden = true
            break
        case .correct:
            bgView.backgroundColor = UIColor(hex: 0xE6F6E5)
            bgView.layer.borderWidth = 0
            contentLabel.textColor = UIColor(hex: 0x10CB4B)
            statusImage.isHidden = false
            statusImage.image = UIImage(named: "right")
            judgeIcon.image = UIImage(named: "radio_right")
            break
        case .wrong:
            bgView.backgroundColor = UIColor(hex: 0xFFE1E1)
            bgView.layer.borderWidth = 0
            contentLabel.textColor = UIColor(hex: 0xFF7979)
            statusImage.isHidden = false
            statusImage.image = UIImage(named: "fault")
            judgeIcon.image = UIImage(named: "radio_fault")
            break
        }
    }
    
}

