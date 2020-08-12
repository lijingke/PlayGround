//
//  AidsQuesResultView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/8/12.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class QuestionnaireResultView: UIView {
    
    // MARK: - Property
    public var dataSource: [QuestionEntity] = []
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.contentSize = contentView.frame.size
    }
    
    // MARK: Lazy Get
    lazy var segmentBar: ResultSegmentBar = {
        let bar = ResultSegmentBar()
        bar.delegate = self
        bar.setScrollValue(value: 0)
        return bar
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
        view.isPagingEnabled = true
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    lazy var syphilisTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.register(QuestionnaireTableViewCell.self, forCellReuseIdentifier: QuestionnaireTableViewCell.identifier)
        table.separatorStyle = .none
        table.estimatedRowHeight = 100
        return table
    }()
    
    lazy var aidsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.register(QuestionnaireTableViewCell.self, forCellReuseIdentifier: QuestionnaireTableViewCell.identifier)
        table.separatorStyle = .none
        table.estimatedRowHeight = 100
        return table
    }()

    lazy var syphilisHeadView: SyphilisQuesHeadView = {
        let view = SyphilisQuesHeadView()
        return view
    }()
    
    lazy var aidsHeadView: AidsQuesHeadView = {
           let view = AidsQuesHeadView()
           return view
       }()
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hex: 0xED5338)
        btn.setTitle("再测一次", for: .normal)
        return btn
    }()
}

// MARK: - UI && Data
extension QuestionnaireResultView {
    
    private func setupUI() {
        addSubview(segmentBar)
        addSubview(scrollView)
        addSubview(submitBtn)
        scrollView.addSubview(contentView)
        contentView.addSubview(syphilisTableView)
        contentView.addSubview(aidsTableView)

        segmentBar.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(62)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(submitBtn.snp.top).offset(-19.5)
        }
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth * 2)
            make.height.equalToSuperview()
        }
        syphilisTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        aidsTableView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(37.5)
            make.right.equalToSuperview().offset(-37.5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
        
        let sHeight = syphilisHeadView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var sFrame = self.syphilisHeadView.frame
        sFrame.size.height = sHeight
        syphilisHeadView.frame = sFrame
        syphilisHeadView.setNeedsLayout()
        syphilisTableView.tableHeaderView = syphilisHeadView
        syphilisTableView.tableFooterView = UIView(frame: .zero)
        
        let aHeight = aidsHeadView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var aFrame = self.aidsHeadView.frame
        aFrame.size.height = aHeight
        aidsHeadView.frame = aFrame
        aidsHeadView.setNeedsLayout()
        aidsTableView.tableHeaderView = aidsHeadView
        aidsTableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    public func setupData(_ dataSource: [QuestionEntity]) {
        self.dataSource = dataSource
        let wrongCount = dataSource.filter({($0.answers?.contains(where: {$0.status == .wrong}) ?? false)}).count
        syphilisHeadView.setupData(status: .fail, allCount: dataSource.count, wrongCount: wrongCount)
        aidsHeadView.setupData(status: .pass, allCount: 0, wrongCount: 0)
        syphilisTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension QuestionnaireResultView: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension QuestionnaireResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionnaireTableViewCell.identifier, for: indexPath) as? QuestionnaireTableViewCell else { return UITableViewCell() }
        cell.entity = dataSource[indexPath.row]
        return cell
    }

}

// MARK: - SegmentBarDelegate
extension QuestionnaireResultView: ResultSegmentBarDelegate {
    func segmentBarDidSelect(fromIndex: NSInteger) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(fromIndex) * scrollView.bounds.width, y: scrollView.contentOffset.y), animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension QuestionnaireResultView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UITableView.self) {
            return
        }
        let value = scrollView.contentOffset.x / scrollView.bounds.size.width
        segmentBar.setScrollValue(value: value)
    }
}
