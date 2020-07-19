//
//  MyPointsViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/16.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class MyPointsViewController: UIViewController {
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Lazt Get
    lazy var mainView: MyPointsView = {
        let view = MyPointsView()
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
}

// MARK: - UI
extension MyPointsViewController {
    
    private func setupNavi() {
        
        navigationItem.title = "我的积分"

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
        
        let rightBtn = UIBarButtonItem(title: "规则", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBtn
        
    }
    private func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Data
extension MyPointsViewController {
    private func creatFakeData() {
        var dataSource: [MagazineInfoEntity] = []
        for i in 0..<5 {
            var entity = MagazineInfoEntity()
            if i % 2 == 0 {
                entity.isAnnual = true
            } else {
                entity.isAnnual = false
            }
            entity.magazineTitle = entity.isAnnual ? "中华皮肤科杂志电子版激活码（年）" : "中华皮肤科杂志电子版激活码（月）"
            entity.needPoints = 3000
            entity.exchangeNum = i
            entity.coverURL = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595150773583&di=3defd5ed66c3b383bb56f13ab4e2ea44&imgtype=0&src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201604%2F28%2F20160428183154_vhrJa.jpeg"
            dataSource.append(entity)
        }
        mainView.setupData(dataSource: dataSource)
    }
}

// MARK: - MyPointsViewProtocol
extension MyPointsViewController: MyPointsViewProtocol {
    
    func jumpToPointRecords() {
        let vc = PointsRecordsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func jumpToExchangeRecords() {
        let vc = ExchangeRecordsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func jumpToExchangeView(with magazineInfo: MagazineInfoEntity) {
        let vc = ExchangeViewController()
        vc.entity = magazineInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
