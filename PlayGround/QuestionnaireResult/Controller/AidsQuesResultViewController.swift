//
//  QuestionnaireResultViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/8/12.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

class QuestionnaireResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.isTranslucent = false
        setupUI()
        creatData()
    }
    
    private func setupUI() {
        navigationItem.title = "知晓率调查"
        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var mainView: AidsQuesResultView = {
        let view = AidsQuesResultView()
        return view
    }()
    
}

extension QuestionnaireResultViewController {
    private func creatData() {
        var dataSource: [QuestionEntity] = []
        for _ in 0..<10 {
            var entity = QuestionEntity()
            entity.title = "梅毒主要是通过性接触传播的吗？"
            var answers: [QuestionEntity.AnswerEntity] = []
            for _ in 0..<3 {
                var answer = QuestionEntity.AnswerEntity()
                answer.title = "是的"
                answer.status = .wrong
                answers.append(answer)
            }
            entity.answers = answers
            dataSource.append(entity)
        }
        mainView.setupData(dataSource)
    }
}
