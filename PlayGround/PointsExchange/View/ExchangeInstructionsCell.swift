//
//  ExchangeInstructionsCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeInstructionsCell: UITableViewCell {
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = getInstructionsContent()
        label.numberOfLines = 0
        return label
    }()
    
}

extension ExchangeInstructionsCell {
    
    private func setupUI() {
        contentView.addSubview(instructionsLabel)
        instructionsLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
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
