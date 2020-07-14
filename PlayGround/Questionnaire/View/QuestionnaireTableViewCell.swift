//
//  QuestionnaireTableViewCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation
import UIKit

class QuestionnaireTableViewCell: UITableViewCell {
    
    public var entity = QuestionEntity() {
        didSet {
            setupData()
        }
    }
    public var answersArray: [AnswerChooseView] = []
    
    private var chooseView: AnswerChooseView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(question)
        addSubview(indictorView)
        addSubview(separatorLine)
        indictorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(22.5)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 7, height: 7))
        }
        question.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(indictorView.snp.right).offset(5.5)
            make.right.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
        separatorLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(17.5)
            make.right.equalToSuperview().offset(-17.5)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    public func setupData() {
        question.text = entity.title
        setNeedsLayout()
        layoutIfNeeded()
        
        for subview in subviews {
            if subview.isKind(of: AnswerChooseView.self) {
                subview.removeFromSuperview()
            }
        }
        
        let size = question.text?.getTextSize(size: question.frame.size, attributesDict: [.font: question.font!])
        
        if let answers = entity.answers {
            let leftEdge: CGFloat = 26.6
            let topEdge = 15 + (size?.height ?? 0) + 5
            let answerW = (UIScreen.main.bounds.width - leftEdge * 2) / CGFloat(answers.count)
            
            for i in 0..<answers.count {
                let view = AnswerChooseView()
                view.setupData(answer: answers[i].title ?? "", status: answers[i].status)
                view.frame = CGRect(x: leftEdge + answerW * CGFloat(i), y: topEdge, width: answerW, height: 40)
                addSubview(view)
            }
            
            question.snp.updateConstraints { (make) in
                make.bottom.equalToSuperview().offset(-40 - 14.5)
            }
        }
        
    }
    
    lazy var question: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var indictorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x4A5EFF)
        view.layer.cornerRadius = 3.5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE8E9EC)
        return view
    }()
    
}
