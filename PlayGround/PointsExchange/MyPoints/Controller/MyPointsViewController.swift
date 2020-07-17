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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavi()
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

extension MyPointsViewController: MyPointsViewProtocol {
    
    func jumpToPointRecords() {
        let vc = PointsRecordsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func jumpToExchangeRecords() {
        let vc = ExchangeRecordsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func jumpToExchangeView() {
        let vc = ExchangeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
