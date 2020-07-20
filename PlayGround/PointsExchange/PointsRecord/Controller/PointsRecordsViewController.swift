//
//  PointsRecordsViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class PointsRecordsViewController: UIViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        creatFakeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavi()
    }
    
    // MARK: Lazy Get
    lazy var mainView: PointsRecordsView = {
        let view = PointsRecordsView()
        view.delegate = self
        return view
    }()
    
}

// MARK: -
extension PointsRecordsViewController: ExchangeRecordProtocol {
    func jumpToExchangeDetail(with record: MonthlyPointsEntity.PointsChangeEntity) {
        var entity = ExchangeRecordModel()
        entity.title = "中华皮肤科杂志电子版激活码（年）"
        entity.coverURL = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595156615146&di=dfe1d2b56a47af6aa714f5c2afc741c5&imgtype=0&src=http%3A%2F%2F02imgmini.eastday.com%2Fmobile%2F20181106%2F20181106170917_96c0333f9e103b4b1abc3ec6ab20fdbd_1.jpeg"
        entity.exchangeTime = "2020-6-20"
        entity.spendPoints = 100
        entity.activationCode = "wheel"
        let vc = ExchangeDetailViewController()
        vc.recordEntity = entity
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

// MARK: - UI
extension PointsRecordsViewController {
    
    private func setupNavi() {
        navigationItem.title = "积分明细"
        // 1.设置导航栏标题属性：设置标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        // 2.设置导航栏前景色：设置item指示色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 3.设置导航栏半透明
        navigationController?.navigationBar.isTranslucent = true
        // 4.设置导航栏背景图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // 5.设置导航栏阴影图片
        navigationController?.navigationBar.getNaviLine()?.isHidden = true
    }
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Data
extension PointsRecordsViewController {
    private func creatFakeData() {
        var dataArray: [MonthlyPointsEntity] = []
        for i in 1...12 {
            var entity = MonthlyPointsEntity()
            entity.month = "2020年\(i)月"
            var pointsArray: [MonthlyPointsEntity.PointsChangeEntity] = []
            for j in 0..<10 {
                var pointsEntity = MonthlyPointsEntity.PointsChangeEntity()
                if j % 2 == 0 {
                    pointsEntity.count = 20
                    pointsEntity.title = "发布文章"
                } else {
                    pointsEntity.count = -30
                    pointsEntity.title = "积分兑换"
                }
                pointsEntity.changeTime = "2019-03-08 02:25"
                
                pointsArray.append(pointsEntity)
            }
            
            if i != 3 {
                entity.pointsArray = pointsArray
            }
            dataArray.append(entity)
        }
        mainView.setupData(dataSource: dataArray)
    }
}
