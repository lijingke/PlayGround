//
//  SyphilisQuesHeadView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/8/12.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class SyphilisQuesHeadView: UIView {
    
    enum Status {
        case pass
        case fail
    }
    
    // MARK: Lift Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pass_bg")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.semibold(26)
        return label
    }()
    
    lazy var labelLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x14A265, alpha: 0.26)
        return view
    }()
    
    lazy var contentLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(16)
        label.textColor = .white
        label.text = "您真棒！快将这个问卷分享给更多需要的人吧~"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var summarizerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(16)
        label.textColor = .white
        return label
    }()
    
}

// MARK: - Setup
extension SyphilisQuesHeadView {
    
    public func setupData(status:Status, allCount: Int, wrongCount: Int) {
        switch status {
        case .pass:
            bgImageView.image = UIImage(named: "pass_bg")
            titleLabel.text = "顺利过关"
            contentLable.text = "您真棒！快将这个问卷分享给更多需要的人吧~"
            labelLine.backgroundColor = UIColor(hex: 0x14A265, alpha: 0.26)
            summarizerLabel.text = "（共\(allCount)题 答对\(allCount - wrongCount)题）"
            break
        case .fail:
            bgImageView.image = UIImage(named: "fail_bg")
            titleLabel.text = "知晓率不通过"
            contentLable.text = "很遗憾，为了您的健康看看下面正确防护知识答案，再测一次吧~"
            labelLine.backgroundColor = UIColor(hex: 0x6E6E6D, alpha: 0.26)
            summarizerLabel.text = "（共\(allCount)题 答错\(wrongCount)题）"
            break
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func setupUI() {
        snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        addSubview(bgImageView)
        addSubview(titleLabel)
        addSubview(labelLine)
        addSubview(contentLable)
        addSubview(summarizerLabel)
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(29.5)
            make.left.equalToSuperview().offset(30)
        }
        labelLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(titleLabel)
            make.height.equalTo(10)
        }
        summarizerLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelLine)
            make.left.equalTo(labelLine.snp.right)
        }
        contentLable.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(14.5)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-32.5)
        }
        
        bgImageView.clipsToBounds = true
    }

}
