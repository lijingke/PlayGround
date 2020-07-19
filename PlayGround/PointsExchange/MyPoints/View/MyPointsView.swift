//
//  MyPointsView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MyPointsView: UIView {
    
    // MARK: Property
    public weak var delegate: MyPointsViewProtocol?
    private var dataSource: [MagazineInfoEntity] = []
    private var scrollArray: [String] = []
    
    // MARK: - Lift Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy Get
    lazy var bgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 132
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.register(PointRewardInfoTableCell.self, forCellReuseIdentifier: PointRewardInfoTableCell.identifier)
        table.register(MyPointsHeaderView.self, forHeaderFooterViewReuseIdentifier: MyPointsHeaderView.identifer)
        return table
    }()
    
    lazy var totalIntegral: UILabel = {
        let label = UILabel()
        label.text = "20000"
        label.textColor = .white
        label.font = UIFont.medium(30)
        return label
    }()
    
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "积分余额"
        label.textColor = .white
        label.font = UIFont.regular(14)
        return label
    }()
    
    lazy var detailsBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 1
        btn.titleLabel?.font = UIFont.regular(15)
        btn.setTitle("积分明细", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 17
        btn.addTarget(self, action: #selector(self.btnClicked(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var exchangeHistoryBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tag = 2
        btn.titleLabel?.font = UIFont.regular(15)
        btn.setTitle("兑换记录", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 0.5
        btn.layer.cornerRadius = 17
        btn.addTarget(self, action: #selector(self.btnClicked(sender:)), for: .touchUpInside)
        return btn
    }()
    
    
}

// MARK: - Data
extension MyPointsView {
    @objc private func btnClicked(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            delegate?.jumpToPointRecords()
        case 2:
            delegate?.jumpToExchangeRecords()
        default:
            break
        }
    }
}

// MARK: - UI
extension MyPointsView {
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(totalIntegral)
        bgView.addSubview(hintLabel)
        bgView.addSubview(detailsBtn)
        bgView.addSubview(exchangeHistoryBtn)
        totalIntegral.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        hintLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(totalIntegral)
            make.top.equalTo(totalIntegral.snp.bottom)
        }
        detailsBtn.snp.makeConstraints { (make) in
            make.top.equalTo(hintLabel.snp.bottom).offset(14.5)
            make.right.equalTo(bgView.snp.centerX).offset(-28)
            make.size.equalTo(CGSize(width: 109, height: 34))
        }
        exchangeHistoryBtn.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.centerX).offset(28)
            make.top.size.equalTo(detailsBtn)
        }
        addSubview(tableView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK: - Data
extension MyPointsView {
    public func setupData(dataSource: [MagazineInfoEntity], dynamic: [String]) {
        self.dataSource = dataSource
        self.scrollArray = dynamic
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension MyPointsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPointsHeaderView.identifer) as? MyPointsHeaderView else { return UIView() }
        header.setupData(scrollArray: self.scrollArray)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        delegate?.jumpToExchangeView(with: data)
    }
}

// MARK: - UITableViewDataSource
extension MyPointsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PointRewardInfoTableCell.identifier, for: indexPath) as? PointRewardInfoTableCell else {
            return UITableViewCell()
        }
        let data = dataSource[indexPath.row]
        cell.setupData(magazine: data)
        return cell
    }
    
    
    
}
