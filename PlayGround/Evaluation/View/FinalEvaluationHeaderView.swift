//
//  FinalEvaluationHeaderView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/22.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image")
        return view
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.semibold(20)
        label.text = "3/20"
        label.textColor = .white
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(17)
        label.text = "倒计时"
        label.textColor = .white
        return label
    }()
    
    lazy var separateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(17)
        label.text = ":"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var hourBtnOne: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "box"), for: .normal)
        btn.setTitle("2", for: .normal)
        btn.titleLabel?.font = UIFont.semibold(20)
        return btn
    }()
    
    lazy var hourBtnTwo: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "box"), for: .normal)
        btn.setTitle("0", for: .normal)
        btn.titleLabel?.font = UIFont.semibold(20)
        return btn
    }()

    lazy var minuteBtnOne: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "box"), for: .normal)
        btn.setTitle("0", for: .normal)
        btn.titleLabel?.font = UIFont.semibold(20)
        return btn
    }()

    lazy var minuteBtnTwo: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "box"), for: .normal)
        btn.setTitle("0", for: .normal)
        btn.titleLabel?.font = UIFont.semibold(20)
        return btn
    }()

}

// MARK: - UI && Data
extension FinalEvaluationHeaderView {
    private func setupUI() {
        addSubview(bgImageView)
        bgImageView.addSubview(progressLabel)
        
        bgImageView.addSubview(hourBtnOne)
        bgImageView.addSubview(hourBtnTwo)
        bgImageView.addSubview(minuteBtnOne)
        bgImageView.addSubview(minuteBtnTwo)
        bgImageView.addSubview(separateLabel)
        bgImageView.addSubview(countLabel)
        
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        progressLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(31.5)
            make.left.equalToSuperview().offset(29.5)
        }
        minuteBtnTwo.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-22)
            make.centerY.equalTo(progressLabel)
        }
        
        minuteBtnOne.snp.makeConstraints { (make) in
            make.centerY.equalTo(minuteBtnTwo)
            make.right.equalTo(minuteBtnTwo.snp.left).offset(-2)
        }
        
        separateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(minuteBtnOne)
            make.left.equalTo(hourBtnTwo.snp.right)
            make.right.equalTo(minuteBtnOne.snp.left)
        }
        
        hourBtnTwo.snp.makeConstraints { (make) in
            make.centerY.equalTo(minuteBtnOne)
            make.right.equalTo(minuteBtnOne.snp.left).offset(-12.5)
        }
        
        hourBtnOne.snp.makeConstraints { (make) in
            make.centerY.equalTo(hourBtnTwo)
            make.right.equalTo(hourBtnTwo.snp.left).offset(-2)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(hourBtnOne)
            make.right.equalTo(hourBtnOne.snp.left).offset(-13.5)
        }
    }
    
    public func setupCountDown(_ timeArray: [Character]) {
        if timeArray.count == 4 {
            hourBtnOne.setTitle(String(timeArray[0]), for: .normal)
            hourBtnTwo.setTitle(String(timeArray[1]), for: .normal)
            minuteBtnOne.setTitle(String(timeArray[2]), for: .normal)
            minuteBtnTwo.setTitle(String(timeArray[3]), for: .normal)
        }
    }
    
    public func setupProgress(current: Int, count: Int) {
        let progress = "\(current)/\(count)"
        let nsRange = progress.toNSRange(progress.range(of: "/")!)
        let atr = NSMutableAttributedString(string: progress)
        atr.addAttributes([.foregroundColor : UIColor.white, .font:UIFont.semibold(35)!], range: NSRange(location: 0, length: nsRange.location + 1))
        progressLabel.attributedText = atr
    }
}
