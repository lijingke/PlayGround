//
//  QuestionnaireView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class QuestionnaireView: UIView {
    
    public var dataSource: [QuestionEntity] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        addSubview(submitBtn)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(submitBtn.snp.top).offset(-19.5)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(37.5)
            make.right.equalToSuperview().offset(-37.5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
        let height = headView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.headView.frame
        frame.size.height = height
        headView.frame = frame
        headView.setNeedsLayout()
        tableView.tableHeaderView = headView
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    public func setupData(_ dataSource: [QuestionEntity]) {
        self.dataSource = dataSource
        let wrongCount = dataSource.filter({($0.answers?.contains(where: {$0.status == .wrong}) ?? false)}).count
        headView.setupData(status: .fail, allCount: dataSource.count, wrongCount: wrongCount)
        tableView.reloadData()
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.register(QuestionnaireTableViewCell.self, forCellReuseIdentifier: QuestionnaireTableViewCell.identifer)
        table.separatorStyle = .none
        table.estimatedRowHeight = 100
        return table
    }()
    
    lazy var headView: QuestionnaireHeadView = {
        let view = QuestionnaireHeadView()
        return view
    }()
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hex: 0xED5338)
        btn.setTitle("再测一次", for: .normal)
        return btn
    }()
}

extension QuestionnaireView: UITableViewDelegate {
    
}

extension QuestionnaireView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionnaireTableViewCell.identifer, for: indexPath) as? QuestionnaireTableViewCell else { return UITableViewCell() }
        cell.entity = dataSource[indexPath.row]
        return cell
    }

}
