//
//  ExchangeRecordsViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeRecordsViewController: UIViewController {
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
    lazy var mainView: ExchangeRecordsView = {
        let view = ExchangeRecordsView()
        view.delegate = self
        return view
    }()
}

// MARK: - UI
extension ExchangeRecordsViewController {
    
    private func setupNavi() {
        navigationItem.title = "兑换记录"
        // 1.设置导航栏标题属性：设置标题颜色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        // 2.设置导航栏前景色：设置item指示色
        navigationController?.navigationBar.tintColor = UIColor.black
        // 3.设置导航栏半透明
        navigationController?.navigationBar.isTranslucent = false
        // 4.设置阴影
        navigationController?.navigationBar.getNaviLine()?.isHidden = false
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Data
extension ExchangeRecordsViewController {
    private func creatFakeData() {
        var dataSource: [ExchangeRecordModel] = []
        for i in 0..<10 {
            var data = ExchangeRecordModel()
            data.title = "中华皮肤科杂志电子版激活码（年）"
            data.coverURL = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595156615146&di=dfe1d2b56a47af6aa714f5c2afc741c5&imgtype=0&src=http%3A%2F%2F02imgmini.eastday.com%2Fmobile%2F20181106%2F20181106170917_96c0333f9e103b4b1abc3ec6ab20fdbd_1.jpeg"
            data.exchangeTime = "2020-6-20"
            data.spendPoints = i
            data.activationCode = "wheel"
            dataSource.append(data)
        }
        mainView.setupData(dataSource: dataSource)
    }
}

// MARK: - ExchangeRecordsEventProtocol
extension ExchangeRecordsViewController: ExchangeRecordsEventProtocol {
    
    func recordClicked(_ recordInfo: ExchangeRecordModel) {
        let vc = ExchangeDetailViewController()
        vc.recordEntity = recordInfo
        navigationController?.pushViewController(vc, animated: true)
    }
}
