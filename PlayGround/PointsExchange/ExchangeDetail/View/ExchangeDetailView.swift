//
//  ExchangeDetailView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeDetailView: UIView {
    // MARK: Lift Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Get
    lazy var coverImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img")
        view.contentMode = .center
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "中华皮肤科杂志电子版激活码（年）"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.medium(18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var codeDetailsView: ActivationCodeDetailsView = {
        let view = ActivationCodeDetailsView()
        return view
    }()
    
    lazy var exchangeInstructionsView: ExchangeInstructionsView = {
        let view = ExchangeInstructionsView()
        return view
    }()
    
}

// MARK: - UI
extension ExchangeDetailView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(coverImgView)
        addSubview(titleLabel)
        addSubview(codeDetailsView)
        addSubview(exchangeInstructionsView)
        coverImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(snp.width).multipliedBy(0.533)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImgView.snp.bottom).offset(20.5)
            make.left.equalToSuperview().offset(15)
        }
        codeDetailsView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(98.5)
        }
        exchangeInstructionsView.snp.makeConstraints { (make) in
            make.top.equalTo(codeDetailsView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK: - Data
extension ExchangeDetailView {
    public func setupData(_ data: ExchangeRecordModel) {
        coverImgView.sd_setImage(with: URL(string: data.coverURL ?? ""), placeholderImage: UIImage(named: "img")) { [weak self] (image, _, _, _) in
            let cropImage = image?.crop(ratio: 1.875, cropType: .top)
            self?.coverImgView.image = cropImage
        }
        titleLabel.text = data.title
        codeDetailsView.setupData(data: data)
    }
}
