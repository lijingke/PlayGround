//
//  MagazineDetailTableCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MagazineDetailTableCell: UITableViewCell {
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "中文摘要："
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x7E7E7E)
        return label
    }()
    
    lazy var contentLabel: UILabel = {let label = UILabel()
        label.text = """
        【摘要】 目的 评价重组人Ⅱ型肿瘤坏死因子受体-抗体融合蛋白（rhTNFR：Fc）治疗由药物引起的中毒性表皮坏死松解症（TEN）的疗效及安全性。方法 2009—2018年于苏州大学附属第二医院等8个中心纳入22例TEN患者，男10例、女12例，年龄22 ~ 75岁。采用rhTNFR：Fc 25 mg/次皮下注射治疗，首剂加倍，每3天1次，连续治疗6 ~ 8次。治疗前及治疗后第4、7、10、13、16、19、22、25天评估患者药疹面积和严重程度指数（DASI）评分、DASI改善指数（DASI50、DASI75、DASI90）；微量样本多指标流式蛋白定量技术检测外周血及疱液TNF-α水平。治疗过程中监测患者体温、皮疹变化及肝肾功能，记录不良事件。统计分析采用重复测量方差分析、配对t检验及Pearson相关分析。结果 22例患者中，未合并感染的20例在首次治疗后24 ~ 72 h体温停止升高，48 ~120 h恢复正常。22例首次治疗后24 ~ 48 h控制水疱新发，48 ~ 96 h皮肤颜色由鲜红色转为暗紫色，2周后皮损基本恢复正常。治疗2 ~ 4周，19例肝功能异常患者丙氨酸转氨酶及天冬氨酸转氨酶水平恢复正常。治疗4 ~ 13 d，7例肾功能异常者肌酐、尿素氮得到控制。治疗过程中，22例患者DASI评分逐渐下降（F = 532.81，P＜0.01），从治疗前53.64 ± 8.67降至治疗25 d时的2.05 ± 1.21（t = 26.60，P < 0.001）。治疗第10天，22例（
        """
        label.font = UIFont.regular(16)
        label.textColor = UIColor(hex: 0x7E7E7E)
        label.numberOfLines = 0
        return label
    }()
}

// MARK: - UI
extension MagazineDetailTableCell {
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(107)
            
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right)
            make.right.equalToSuperview().offset(-15.5)
            make.bottom.equalToSuperview().offset(-8)}
    }
}
