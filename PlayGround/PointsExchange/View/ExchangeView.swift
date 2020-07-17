//
//  ExchangeView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeView: UIView {
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        scrollView.contentSize = contentView.frame.size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Get
    lazy var bgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img")
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
    
    lazy var requiredPoints: UILabel = {
        let label = UILabel()
        label.text = "3000积分"
        label.textColor = UIColor(hex: 0xF0A044)
        label.font = UIFont.regular(17)
        return label
    }()
    
    lazy var chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "选择兑换期刊"
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.regular(17)
        return label
    }()
    
    lazy var chooseLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xE3E8FF)
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var chooseBtn: ChooseView = {
        let view = ChooseView()
        view.clickAction = { () in
            print("click")
        }
        return view
    }()
    
    lazy var separateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF7F7F7)
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.bounces = false
        view.isPagingEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableViewOne: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.tag = 1
        table.delegate = self
        table.dataSource = self
        table.register(ExchangeInstructionsCell.self, forCellReuseIdentifier: ExchangeInstructionsCell.identifier)
        table.separatorStyle = .none
        table.estimatedRowHeight = 320
        return table
    }()
    
    lazy var tableViewTwo: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.tag = 2
        table.delegate = self
        table.dataSource = self
        table.register(MonthlyTableViewCell.self, forCellReuseIdentifier: MonthlyTableViewCell.identifier)
        table.register(MagazineInstructionCell.self, forCellReuseIdentifier: MagazineInstructionCell.identifier)

        table.separatorStyle = .none
        return table
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var exchangeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("立即兑换", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: 0x5161F9)
        btn.titleLabel?.font = UIFont.regular(17)
        return btn
    }()
    
}

// MARK: - UI
extension ExchangeView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(bgView)
        addSubview(titleLabel)
        addSubview(requiredPoints)
        addSubview(chooseLine)
        addSubview(chooseLabel)
        addSubview(chooseBtn)
        addSubview(separateLine)
        addSubview(exchangeBtn)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(snp.width).multipliedBy(0.533)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.bottom).offset(20.5)
            make.left.equalToSuperview().offset(15)
        }
        requiredPoints.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
        }
        chooseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(requiredPoints.snp.bottom).offset(20.5)
            make.left.equalTo(requiredPoints)
        }
        chooseLine.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(chooseLabel)
            make.size.equalTo(CGSize(width: 110, height: 7.5))
        }
        chooseBtn.snp.makeConstraints { (make) in
            make.top.equalTo(chooseLine.snp.bottom).offset(14.5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(45)
        }
        separateLine.snp.makeConstraints { (make) in
            make.top.equalTo(chooseBtn.snp.bottom).offset(28.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(11.5)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(separateLine.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(exchangeBtn.snp.top)
        }
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth * 2)
            make.height.equalToSuperview()
        }
        
        contentView.addSubview(tableViewOne)
        contentView.addSubview(tableViewTwo)
        
        tableViewOne.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        tableViewTwo.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(tableViewOne)
        }
        
        exchangeBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(45)
        }
    }
}

// MARK: - UITableViewDelegate
extension ExchangeView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension ExchangeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 1:
            return 1
        case 2:
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeInstructionsCell.identifier, for: indexPath)
            return cell
        case 2:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MonthlyTableViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MagazineInstructionCell.identifier, for: indexPath)
                return cell
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    
}
