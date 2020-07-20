//
//  PointsRecordsTableSectionFooter.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/20.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsTableSectionFooter: UITableViewHeaderFooterView {
    
    // MARK: Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
