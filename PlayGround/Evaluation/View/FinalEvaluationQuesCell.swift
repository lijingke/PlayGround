//
//  FinalEvaluationQuesCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/22.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationQuesCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    lazy var quesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(18)
        label.text = "根据国家规定，梅毒病例报告实行以下哪项制度？"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
}

extension FinalEvaluationQuesCell {
    private func setupUI() {
        backgroundColor = .white
        contentView.addSubview(quesLabel)
        quesLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(20.5)
            make.right.equalToSuperview().offset(-18.5)
            make.bottom.equalToSuperview().offset(-19)
        }
        clipsToBounds = true
    }
    
    public func setupData(_ content: String) {
        quesLabel.text = content
    }
}
