//
//  ExchangeRecordsView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeRecordsView: UIView {
    
    // MARK: Property
    public weak var delegate: ExchangeRecordsEventProtocol?
    
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
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(ExchangeRecordsTableCell.self, forCellReuseIdentifier: ExchangeRecordsTableCell.identifier)
        return table
    }()
}

// MARK: - UI
extension ExchangeRecordsView {
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ExchangeRecordsView: UITableViewDelegate {
    
}

extension ExchangeRecordsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRecordsTableCell.identifier, for: indexPath) as? ExchangeRecordsTableCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.recordClicked()
    }
    
    
}
