//
//  DoctorLeftView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorLeftView: UIView {
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headView: DoctorLeftHeaderView = {
        let view = DoctorLeftHeaderView()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DoctorInfoTableViewCell.self, forCellReuseIdentifier: DoctorInfoTableViewCell.reuseIdentifier)
        table.register(DoctorInfoTableHeaderView.self, forHeaderFooterViewReuseIdentifier: DoctorInfoTableHeaderView.reuseIdentifier)
        table.register(DoctorInfoTableFooterView.self, forHeaderFooterViewReuseIdentifier: DoctorInfoTableFooterView.reuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.estimatedRowHeight = 120
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
}

// MARK: - UI
extension DoctorLeftView {
    private func setupUI() {
        addSubview(headView)
        addSubview(tableView)
        headView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension DoctorLeftView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DoctorInfoTableHeaderView.reuseIdentifier) as? DoctorInfoTableHeaderView else { return nil }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footView = tableView.dequeueReusableHeaderFooterView(withIdentifier: DoctorInfoTableFooterView.reuseIdentifier) as? DoctorInfoTableFooterView else { return nil }
        return footView
    }
}

// MARK: - UITableViewDataSource
extension DoctorLeftView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DoctorInfoTableViewCell.reuseIdentifier, for: indexPath) as? DoctorInfoTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
