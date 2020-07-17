//
//  MagazineDetailView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MagazineDetailView: UIView {
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(MagazineDetailTableCell.self, forCellReuseIdentifier: MagazineDetailTableCell.identifier)
        table.register(MagazineDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: MagazineDetailHeaderView.identifer)
        return table
    }()
    
}

// MARK: - UI
extension MagazineDetailView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension MagazineDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MagazineDetailHeaderView.identifer) else { return UIView() }
        return header
    }
}

// MARK: - UITableViewDataSource
extension MagazineDetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MagazineDetailTableCell.identifier, for: indexPath) as? MagazineDetailTableCell else { return UITableViewCell() }
        return cell
    }
    
}
