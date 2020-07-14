//
//  DenyLoginViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/6.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DenyLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        setupUI()
    }
    
    lazy var mainView: DenyLoginView = {
        let view = DenyLoginView()
        return view
    }()
    
}

extension DenyLoginViewController {
    private func setupUI() {
        setupNav()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func setupNav() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
    }
}
