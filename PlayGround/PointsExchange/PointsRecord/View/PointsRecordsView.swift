//
//  PointsRecordsView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsView: UIView {
    
    // MARK: Property
    private var dataSource: [MonthlyPointsEntity] = []
    
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
        table.register(PointsNoRecordsTableCell.self, forCellReuseIdentifier: PointsNoRecordsTableCell.identifier)
        table.register(PointsRecordsTableSectionHeader.self, forHeaderFooterViewReuseIdentifier: PointsRecordsTableSectionHeader.identifer)
        table.register(PointsRecordsTableSectionFooter.self, forHeaderFooterViewReuseIdentifier: PointsRecordsTableSectionFooter.identifer)
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

// MARK: - UI
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
    
    private func openSection(section: Int) {
        var model = dataSource[section]
        model.isOpen.toggle()
        var indexArray: [IndexPath] = []
        for i in 0..<model.pointsArray.count {
            let indexPath = IndexPath(row: i, section: section)
            indexArray.append(indexPath)
        }
        dataSource[section] = model
        if indexArray.count == 0 {
            indexArray.append(IndexPath(row: 0, section: section))
        }
        tableView.insertRows(at: indexArray, with: .fade)
    }
    
    private func closeSection(section: Int) {
        var model = dataSource[section]
        model.isOpen.toggle()
        var indexArray: [IndexPath] = []
        for i in 0..<model.pointsArray.count {
            let indexPath = IndexPath(row: i, section: section)
            indexArray.append(indexPath)
        }
        dataSource[section] = model
        if indexArray.count == 0 {
            indexArray.append(IndexPath(row: 0, section: section))
        }
        tableView.deleteRows(at: indexArray, with: .fade)
    }
}

// MARK: - Data
extension PointsRecordsView {
    public func setupData(dataSource: [MonthlyPointsEntity]) {
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension PointsRecordsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PointsRecordsTableSectionHeader.identifer) as? PointsRecordsTableSectionHeader else { return UIView() }
        
        var entity = PointsRecordsTableSectionHeader.RecordHeaderEntity()
        entity.isOpen = dataSource[section].isOpen
        entity.time = dataSource[section].month
        entity.section = section
        header.setupData(entity: entity)
        
        header.openBlock = { [weak self] (headSection) in
            self?.openSection(section: headSection)
        }
        header.closeBlock = { [weak self] (headSection) in
            self?.closeSection(section: headSection)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PointsRecordsTableSectionFooter.identifer) as? PointsRecordsTableSectionFooter else { return UIView() }
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return dataSource[section].isOpen ? CGFloat.leastNormalMagnitude : 10
    }
}

// MARK: - UITableViewDataSource
extension PointsRecordsView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = dataSource[section]
        if data.isOpen {
            let recordsNum = dataSource[section].pointsArray.count
            return recordsNum > 0 ? recordsNum : 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recordsNum = dataSource[indexPath.section].pointsArray.count
        
        if recordsNum > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PointsRecordsTableCell.identifier, for: indexPath) as? PointsRecordsTableCell else { return UITableViewCell() }
            let pointsEntity = dataSource[indexPath.section].pointsArray[indexPath.row]
            cell.setupData(pointsEntity)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PointsNoRecordsTableCell.identifier, for: indexPath) as? PointsNoRecordsTableCell else { return UITableViewCell() }
            return cell
        }

    }
    
}
