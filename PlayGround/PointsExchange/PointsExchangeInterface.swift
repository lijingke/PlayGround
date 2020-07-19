//
//  PointsExchangeInterface.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

protocol MyPointsViewProtocol: NSObject {
    func jumpToPointRecords()
    func jumpToExchangeRecords()
    func jumpToExchangeView(with magazineInfo: MagazineInfoEntity)
}

protocol ExchangeRecordsEventProtocol: NSObject {
    func copyAction()
    func recordClicked()
}

protocol ExchangeViewProtocol: NSObject {
    func jumpToMagazineDetailView(with magazine: ArticleDetailModel)
    func exchangePoints()
}

