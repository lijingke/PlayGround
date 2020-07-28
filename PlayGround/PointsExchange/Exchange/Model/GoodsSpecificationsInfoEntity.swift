//
//  GoodsSpecificationsInfoEntity.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

struct GoodsSpecificationsInfoEntity {
    var id: String?
    var name: String?
    var goodsId: String?
    var year: Int?
    /// 期刊数，月刊没有
    var number: Int?
    // enum{"annual":annual, "monthly":monthly}
    var type: String?
    var creatTime: Int?
    var isSelected: Bool = false

    var subArray: [GoodsSpecificationsInfoEntity]?
}
