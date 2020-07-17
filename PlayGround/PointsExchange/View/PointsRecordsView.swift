//
//  PointsRecordsView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsView: UIView {
    // MARK: Life Cycle
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
        view.image = UIImage(named: "top_bg_title")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(PointsRecordsTableCell.self, forCellReuseIdentifier: PointsRecordsTableCell.identifier)
        table.register(PointsRecordsTableSectionHeader.self, forHeaderFooterViewReuseIdentifier: PointsRecordsTableSectionHeader.identifer)
        return table
    }()
    
    lazy var totalIntegral: UILabel = {
        let label = UILabel()
        label.text = "20000"
        label.textColor = .white
        label.font = UIFont.semibold(34)
        return label
    }()
    
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "积分余额"
        label.textColor = .white
        label.font = UIFont.regular(14)
        return label
    }()
}

extension PointsRecordsView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(bgView)
        bgView.addSubview(totalIntegral)
        bgView.addSubview(hintLabel)
        addSubview(tableView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        hintLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        totalIntegral.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(hintLabel.snp.top)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        let header = PointsRecordsTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 69.5))
        tableView.tableHeaderView = header
    }
}

// MARK: - UITableViewDelegate
extension PointsRecordsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PointsRecordsTableSectionHeader.identifer) as? PointsRecordsTableSectionHeader else { return UIView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

// MARK: - UITableViewDataSource
extension PointsRecordsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PointsRecordsTableCell.identifier, for: indexPath) as? PointsRecordsTableCell else { return UITableViewCell() }
        return cell
    }
    
    
}
