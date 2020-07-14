//
//  DoctorLeftViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/8.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class DoctorLeftViewController: UIViewController {
    
    // MARK: Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.isTranslucent = false
        setupUI()
    }
    
    // MARK: Lazy Get
    
    lazy var mainView: DoctorLeftView = {
        let view = DoctorLeftView()
        return view
    }()
    
}

// MARK: - UI
extension DoctorLeftViewController {
    private func setupUI() {
        navigationItem.title = "未找到医生"
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
