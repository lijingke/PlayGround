//
//  MonthlyTableViewCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MonthlyTableViewCell: UITableViewCell {
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lazy Get
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 44, height: 49)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 9.5
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(MonthlyCollectionCell.self, forCellWithReuseIdentifier: MonthlyCollectionCell.identifier)
        return collection
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xD5D5D5)
        return view
    }()
}

// MARK: - UI
extension MonthlyTableViewCell {
    private func setupUI() {
        contentView.addSubview(collectionView)
        contentView.addSubview(separatorLine)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(102)
        }
        separatorLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MonthlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyCollectionCell.identifier, for: indexPath) as? MonthlyCollectionCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension MonthlyTableViewCell: UICollectionViewDelegate {
    
}
