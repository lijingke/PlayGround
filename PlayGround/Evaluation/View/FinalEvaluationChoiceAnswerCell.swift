//
//  FinalEvaluationChoiceAnswerCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation
import UIKit

class FinalEvaluationChoiceAnswerCell: UITableViewCell {
    
    public var entity: QuestionEntity.AnswerEntity?
    public var clickBlock: ((QuestionEntity.AnswerEntity)->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var answerView: FinalEvaluationChoiceAnswerView = {
        let view = FinalEvaluationChoiceAnswerView()
        view.clickBlock = { [weak self] (entity) in
            self?.clickBlock?(entity)
        }
        return view
    }()
    
}

extension FinalEvaluationChoiceAnswerCell {
    private func setupUI() {
        contentView.addSubview(answerView)
        answerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(11.5)
            make.left.equalToSuperview().offset(20.5)
            make.right.equalToSuperview().offset(-18.5)
            make.bottom.equalToSuperview().offset(-11.5)
        }
    }
    
    public func setupData(entity: QuestionEntity.AnswerEntity) {
        answerView.setupData(entity: entity)
    }
}
