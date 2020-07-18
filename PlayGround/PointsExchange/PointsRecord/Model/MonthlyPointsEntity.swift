//
//  MonthlyPointsEntity.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/18.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

struct MonthlyPointsEntity {
    var month: String?
    var isOpen = true
    var pointsArray: [PointsChangeEntity] = []
    
    struct PointsChangeEntity {
        var title: String?
        var changeTime: String?
        var count: Int?
    }
}
