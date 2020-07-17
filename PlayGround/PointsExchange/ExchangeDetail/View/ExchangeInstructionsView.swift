//
//  ExchangeInstructionsView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeInstructionsView: UIView {
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var indicatorView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_subtitle")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "兑换说明"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.medium(17)
        return label
    }()
    
    lazy var contentView: DisplayTextView = {
        let view = DisplayTextView()
        view.isEditable = false
        view.isScrollEnabled = true
        view.attributedText = getInstructionsContent()
        return view
    }()
    
}

// MARK: - UI
extension ExchangeInstructionsView {
    private func setupUI() {
        addSubview(indicatorView)
        addSubview(titleLabel)
        addSubview(contentView)
        indicatorView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 3, height: 15))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(indicatorView)
            make.left.equalTo(indicatorView.snp.right).offset(8)
        }
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16.5)
            make.left.equalToSuperview().offset(11)
            make.right.equalToSuperview().offset(-11)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Data
extension ExchangeInstructionsView {
    private func getInstructionsContent() -> NSMutableAttributedString {
        let contentStr = """
一、使用有效期：每个激活码仅能激活一次，激活后永久有效。

二、使用说明：
      (1)  微信搜索公众号“中华皮肤科杂志”，并点击关注；
      (2) 进入“在线期刊”—“电子期刊订阅”—“激活码兑换”输入激活码进行兑换。

三、本激活码不支持退换、不变现，兑换状态以商户反馈为准。

四、如有疑问，请咨询：400-6700701。
"""
        let attContent: NSMutableAttributedString = NSMutableAttributedString(string: contentStr)
        attContent.addAttributes([.font : UIFont.regular(16)!, .foregroundColor : UIColor.init(hex: 0x7E7E7E)], range: NSRange(location: 0, length: contentStr.count))
        
        let yellowRange = contentStr.exMatchStrNSRange(matchStr: """
二、使用说明：
      (1)  微信搜索公众号“中华皮肤科杂志”，并点击关注；
      (2) 进入“在线期刊”—“电子期刊订阅”—“激活码兑换”输入激活码进行兑换。
""")
        attContent.addAttributes([.font : UIFont.regular(16)!, .foregroundColor : UIColor(hex: 0xCC8123)], range: yellowRange.first!)
        
        return attContent
    }
}
