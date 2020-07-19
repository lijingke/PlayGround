//
//  ArticleDetailView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/19.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    
    // MARK: Property
    private var entity: ArticleDetailModel?
    
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
        table.register(ArticleDetailTableCell.self, forCellReuseIdentifier: ArticleDetailTableCell.identifier)
        table.register(ArticleDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: ArticleDetailHeaderView.identifer)
        return table
    }()
    
}

// MARK: - UI
extension ArticleDetailView {
    private func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Data
extension ArticleDetailView {
    public func setupData(entity: ArticleDetailModel) {
        self.entity = entity
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ArticleDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ArticleDetailHeaderView.identifer) as? ArticleDetailHeaderView else { return UIView() }
        header.title = entity?.title
        return header
    }
}

// MARK: - UITableViewDataSource
extension ArticleDetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleDetailTableCell.identifier, for: indexPath) as? ArticleDetailTableCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            cell.setupData(title: "作者", content: entity?.author)
        case 1:
            cell.setupData(title: "作者单位", content: entity?.authorEmployer)
        case 2:
            cell.setupData(title: "关键词", content: entity?.keyWords)
        case 3:
            cell.setupData(title: "中文摘要", content: entity?.chineseSummary)
        default:
            break
        }
        return cell
    }
    
}
