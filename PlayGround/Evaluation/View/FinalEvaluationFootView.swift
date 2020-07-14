//
//  FinalEvaluationFootView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/1.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationFootView: UIView {
    
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
        return view
    }()
    
}

extension FinalEvaluationFootView {
    private func setupUI() {
        backgroundColor = .clear
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(60)
        }
        clipsToBounds = true
    }
}
