//
//  DoctorInfoTableViewCell.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorInfoTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DoctorInfoTableViewCell"
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  Lazy Get
    
    lazy var collectionView: UICollectionView = {
            let itemW: CGFloat = 250.0
            let itemH: CGFloat = 100.0
            let layout = UICollectionViewFlowLayout()
            layout.sectionHeadersPinToVisibleBounds = true
            layout.itemSize = CGSize(width: itemW, height: itemH)
            layout.minimumLineSpacing = 30
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.backgroundColor = .white
            collection.register(DoctorInfoCollectionViewCell.self, forCellWithReuseIdentifier: DoctorInfoCollectionViewCell.reuseIdentifier)
            collection.delegate = self
            collection.dataSource = self
            return collection
        }()
}

// MARK: - UI
extension DoctorInfoTableViewCell {
    private func setupUI() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DoctorInfoTableViewCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension DoctorInfoTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorInfoCollectionViewCell.reuseIdentifier, for: indexPath) as? DoctorInfoCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}
