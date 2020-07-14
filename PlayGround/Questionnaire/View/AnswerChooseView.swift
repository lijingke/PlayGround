//
//  AnswerChooseView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class AnswerChooseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(chooseRadioBtn)
        addSubview(answer)
        chooseRadioBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        answer.snp.makeConstraints { (make) in
            make.centerY.equalTo(chooseRadioBtn)
            make.left.equalTo(chooseRadioBtn.snp.right).offset(10)
        }
    }
    
    public func setupData(answer: String, status: AnswerStatus) {
        self.answer.text = answer
        switch status {
        case .correct:
            chooseRadioBtn.setImage(UIImage(named: "ceping_option_n"), for: .normal)
        case .wrong:
            chooseRadioBtn.setImage(UIImage(named: "ceping_option_n"), for: .normal)
        case .defult:
            chooseRadioBtn.setImage(UIImage(named: "ceping_option_n"), for: .normal)
        case .selected:
            break
        }
    }
    
    lazy var answer: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var chooseRadioBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "ceping_option_n"), for: .normal)
        return btn
    }()
    
}
