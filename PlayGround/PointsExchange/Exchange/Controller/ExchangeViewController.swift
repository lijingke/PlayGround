//
//  ExchangeViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/17.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavi()
    }
    
    // MARK: Lazy Get
    lazy var mainView: ExchangeView = {
        let view = ExchangeView()
        view.delegate = self
        return view
    }()
    
}

// MARK: - UI
extension ExchangeViewController {
    private func setupNavi() {
        navigationItem.title = "兑换"
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

// MARK: - ExchangeViewProtocol
extension ExchangeViewController: ExchangeViewProtocol {
    func exchangePoints() {
        
        let view = MagazineIssueHintView()
        UIApplication.shared.windows[0].addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func jumpToMagazineDetailView() {
        let vc = MagazineDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }    
    
}
