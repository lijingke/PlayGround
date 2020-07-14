//
//  TextAlertView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

enum TextAlertButtonType: Int {
    case cancel = 0
    case confirm = 1
}

/// 提示的弹窗
class TextAlertView: UIView {
    public init(title: String, message: String) {
        self.init()
        self.title = title
        self.message = message
        configAlert()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configAlert()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Public
    public var title:String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var message: String? {
        didSet {
            subtitleLabel.text = message
        }
    }
    
    public var confirm: String = "确定" {
        didSet {
            submitButton.setTitle(confirm, for: .normal)
        }
    }
    
    public var cancel: String = "退出" {
        didSet {
            cancelButton.setTitle(cancel, for: .normal)
        }
    }
    
    public func show() {
        guard let vc = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
        self.frame = vc.view.bounds
    }
    
    public func dismiss() {
        self.removeFromSuperview()
        contentView.removeFromSuperview()
    }
    
    public func buttonDidTap(_ closure: ClosureType?) {
        onClickCompletion = closure
    }
    
    // MARK: - Private
    typealias ClosureType = ((_ buttonType: TextAlertButtonType)->Void)
    private var onClickCompletion: ClosureType?
    
    
    // MARK: - Getter
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(18)
        label.textColor = UIColor.rgb(hex: 0x333333)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = title
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.medium(14)
        label.textColor = UIColor.rgb(hex: 0x333333)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.rgb(hex: 0x4E61FB), for: .normal)
        btn.setTitle(confirm, for: .normal)
        btn.titleLabel?.font = UIFont.medium(18)
        btn.backgroundColor = UIColor.rgb(hex: 0xFFFFFF)
        btn.addTarget(self, action: #selector(onclickButtonAction), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    private lazy var cancelButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.rgb(hex: 0x999999), for: .normal)
        btn.setTitle(cancel, for: .normal)
        btn.titleLabel?.font = UIFont.regular(18)
        btn.backgroundColor = UIColor.rgb(hex: 0xFFFFFF)
        btn.addTarget(self, action: #selector(onclickButtonAction), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    
    private lazy var horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xDDDDDD)
        return view
    }()
    
    private lazy var verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xDDDDDD)
        return view
    }()
    
}

extension TextAlertView {
    
    private func configAlert() {
        self.titleLabel.text = title
        self.subtitleLabel.text = message
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.3)
        self.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(submitButton)
        contentView.addSubview(cancelButton)
        contentView.addSubview(verticalLine)
        contentView.addSubview(horizontalLine)
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(52)
            make.right.equalToSuperview().offset(-52)
            make.center.equalToSuperview()
        }
        
        var titleHeight:CGFloat = 0
        if title?.count ?? 0 > 0 {
            titleHeight = 25
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(titleHeight)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-21)
            make.top.equalTo(titleLabel.snp.bottom).offset(titleHeight > 0 ? 12 : 0)
        }
        
        horizontalLine.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        verticalLine.snp.makeConstraints { (make) in
            make.top.equalTo(horizontalLine.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }

        submitButton.snp.makeConstraints { (make) in
            make.top.equalTo(horizontalLine.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(horizontalLine.snp.width).multipliedBy(0.5)
            make.height.equalTo(50)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(submitButton)
            make.left.equalToSuperview()
            make.size.equalTo(submitButton)
        }
    }
    
    @objc private func tapGestureAction() {
        dismiss()
    }
    
    @objc private func onclickButtonAction(_ sender: UIButton) {
        dismiss()
        if let closure = onClickCompletion, let type = TextAlertButtonType(rawValue: sender.tag) {
            closure(type)
        }
    }
    
}
