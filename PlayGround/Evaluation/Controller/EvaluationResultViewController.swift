//
//  EvaluationResultViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

enum ResultType {
    case practice
    case exam
}

class EvaluationResultViewController: UIViewController {
    
    public var entity = FinalEvaluationResultEntity()
    public var pageType: ResultType = .practice {
        didSet {
            mainView.pageType = pageType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    lazy var mainView: EvaluationResultView = {
        let view = EvaluationResultView()
        view.delegate = self
        return view
    }()
    
}

extension EvaluationResultViewController: EvaluationResultViewProtocol {
    func retest() {
        print("再测一次")
        let VCs = self.navigationController?.viewControllers ?? []
        for vc in VCs {
            if vc.isKind(of: ViewController.self) {
                print("返回首页")
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    func back() {
        print("返回")
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UI
extension EvaluationResultViewController {
    
    private func setupUI() {
        self.navigationItem.title = "终期评估考核"
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupData() {
        self.mainView.setupData(self.entity)
    }
    
}
