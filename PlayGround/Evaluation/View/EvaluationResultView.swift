//
//  EvaluationResultView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class EvaluationResultView: UIView {
    
    // MARK: - Property
    weak var delegate: EvaluationResultViewProtocol?
    
    public var pageType: ResultType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.indicatorStyle = .black
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x4E61FB)
        return view
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var conclusionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(30)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var cupImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "unqualified")
        return view
    }()
    
    lazy var gradeView: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "bg_df2"), for: .normal)
        btn.setTitle("", for: .normal)
        btn.titleLabel?.font = UIFont.medium(19)
        btn.setTitleColor(UIColor(hex: 0x585858), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var correctCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x474747)
        label.textAlignment = .center
        return label
    }()
    
    lazy var wrongCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x474747)
        label.textAlignment = .center
        return label
    }()
    
    lazy var unanswerCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x474747)
        label.textAlignment = .center
        return label
    }()
    
    lazy var usedTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x474747)
        label.textAlignment = .center
        return label
    }()
    
    lazy var examinationTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.textColor = UIColor(hex: 0x474747)
        label.textAlignment = .center
        return label
    }()
    
    lazy var retestBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 0
        btn.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        btn.setTitle("再测一次", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.medium(19)
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var returnBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.backgroundColor = .clear
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.medium(19)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        return btn
    }()
}

// MARK: - UI
extension EvaluationResultView {
    
    private func setupUI() {
        backgroundColor = UIColor(hex: 0x4E61FB)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bgView)
        contentView.addSubview(conclusionLabel)
        contentView.addSubview(cupImageView)
        bgView.addSubview(gradeView)
        bgView.addSubview(correctCountLabel)
        bgView.addSubview(wrongCountLabel)
        bgView.addSubview(unanswerCountLabel)
        bgView.addSubview(usedTimeLabel)
        bgView.addSubview(examinationTimeLabel)
        contentView.addSubview(retestBtn)
        contentView.addSubview(returnBtn)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(cupImageView.snp.bottom).offset(-18)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        conclusionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(52.5)
            make.centerX.equalToSuperview()
        }
        cupImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(conclusionLabel.snp.bottom)
        }
        gradeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(36.5)
            make.centerX.equalToSuperview()
        }
        correctCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gradeView.snp.bottom).offset(14.5)
            make.left.right.equalToSuperview()
        }
        wrongCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(correctCountLabel.snp.bottom).offset(5.4)
            make.left.right.equalToSuperview()
        }
        unanswerCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wrongCountLabel.snp.bottom).offset(5.4)
            make.left.right.equalToSuperview()
        }
        usedTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(unanswerCountLabel.snp.bottom).offset(5.4)
            make.left.right.equalToSuperview()
        }
        examinationTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usedTimeLabel.snp.bottom).offset(5.4)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-29)
        }
        retestBtn.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.bottom).offset(45)
            make.left.right.equalTo(bgView)
            make.height.equalTo(50)
        }
        returnBtn.snp.makeConstraints { (make) in
            make.top.equalTo(retestBtn.snp.bottom).offset(12.5)
            make.left.right.height.equalTo(retestBtn)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
        
        scrollView.contentSize = contentView.frame.size
    }
}

// MARK: - Data
extension EvaluationResultView {
    
    @objc private func btnAction(_ sender: UIButton) {
        if sender.tag == 0 {
            delegate?.retest()
        } else {
            delegate?.back()
        }
    }
    
    public func setupData(_ entity: FinalEvaluationResultEntity) {
        gradeView.setTitle("得分：\(entity.totalScore)分", for: .normal)
        correctCountLabel.text = "答对题目数：\(entity.correctCount)"
        wrongCountLabel.text = "错题数：\(entity.wrongCount)"
        unanswerCountLabel.text = "未答题目数：\(entity.unanswerCount)"
        usedTimeLabel.text = "用时：\(entity.usedTime.secondsToChsString())"
        examinationTimeLabel.text = "考试日期：\(entity.examinationTime ?? "")"
        if entity.isPass {
            conclusionLabel.text = "恭喜您!"
            cupImageView.image = UIImage(named: "qualified")
            gradeView.setBackgroundImage(UIImage(named: "bg_df1"), for: .normal)
            gradeView.setTitleColor(UIColor(hex: 0xE56721), for: .normal)
        } else {
            conclusionLabel.text = "再测一次吧!"
            cupImageView.image = UIImage(named: "unqualified")
            gradeView.setBackgroundImage(UIImage(named: "bg_df2"), for: .normal)
            gradeView.setTitleColor(UIColor(hex: 0x585858), for: .normal)
        }
        
        conclusionLabel.isHidden = pageType == .some(.exam)
        
        if pageType == .some(.exam) {
            cupImageView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(conclusionLabel.snp.top)
            }
            returnBtn.isHidden = true
            retestBtn.setTitle("返回", for: .normal)
            retestBtn.tag = 1
        } else {
            cupImageView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(conclusionLabel.snp.bottom)
            }
        }
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
        
        scrollView.contentSize = contentView.frame.size
        
    }
}
