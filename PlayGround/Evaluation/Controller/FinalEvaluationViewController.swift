//
//  FinalEvaluationViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/22.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationViewController: UIViewController {
    
    // MARK: Property
    private var resultEntity: FinalEvaluationResultEntity = FinalEvaluationResultEntity()
    private var dataSource: [QuestionEntity] = []
    
    // MARK: Life Cycle
    init(dataSource: [QuestionEntity]) {
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    deinit {
        print("bye")
    }
    
    private lazy var mainView: FinalEvaluationView = {
        let view = FinalEvaluationView()
        view.delegate = self
        return view
    }()
    
}

// MARK: - FinalEvaluationProtocol
extension FinalEvaluationViewController: FinalEvaluationProtocol {
    
    func submitData(data: [QuestionEntity], autoJump: Bool, usedTime: Int) {
        resultEntity = makeResult(data: data, usedTime: usedTime)
        if autoJump {
            jumpToResult()
        }
    }
    
    func jumpToResult() {
        let vc = EvaluationResultViewController()
        vc.entity = resultEntity
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UI
extension FinalEvaluationViewController {
    
    private func setupNavi() {
        navigationItem.title = "终期评估模拟"
        let leftBtn = UIBarButtonItem(image: UIImage(named: "nav_back_black"), style: .done, target: self, action: #selector(leftBtnAction))
        navigationItem.leftBarButtonItem = leftBtn
    }
    
    @objc private func leftBtnAction() {
        mainView.pauseTimer()
        let alert = TextAlertView(title: "", message: "确定要退出答题？\n退出后作答历史将不会保存")
        alert.confirm = "继续"
        alert.show()
        alert.buttonDidTap { [weak self] (buttonType) in
            switch buttonType {
            case .confirm:
                self?.mainView.reactivateTimer()
                break
            case .cancel:
                self?.navigationController?.popViewController(animated: true)
                break
            }
        }
        
    }
    
    private func setupUI() {
        setupNavi()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Data
extension FinalEvaluationViewController {
    
    private func makeResult(data: [QuestionEntity], usedTime: Int) -> FinalEvaluationResultEntity {
        
        let hasFinishArray = data.filter{($0.answers?.contains(where: {$0.status == .correct || $0.status == .wrong}) ?? false)}
        
        let correctArray = hasFinishArray.filter{!($0.answers?.contains(where: {$0.status == .wrong}) ?? false)}
        
        let wrongArray = hasFinishArray.filter{($0.answers?.contains(where: {$0.status == .wrong}) ?? false)}
        
        var totalScore = 0
        correctArray.forEach { (ques) in
            let correctItem = ques.answers?.filter{$0.status == .correct}.first
            totalScore += correctItem?.score ?? 0
        }
        
        var entity = FinalEvaluationResultEntity()
        entity.totalScore = totalScore
        entity.correctCount = correctArray.count
        entity.wrongCount = wrongArray.count
        entity.unanswerCount = data.count - hasFinishArray.count
        entity.usedTime = usedTime
        entity.examinationTime = Date().toString()
        return entity
    }
    
    private func setupData() {
        var dataSource: [QuestionEntity] = []
        for i in 0...3 {
            var entity = QuestionEntity()
            if i == 0 {
                entity.title = "根据国家规定，梅毒病例报告实行以下哪项制度？"
            } else if i == 1 {
                entity.title = "乱七八糟"
            } else {
                entity.title = "第\(i)题"
            }
            if i == 2 {
                entity.type = .judge
            } else {
                entity.type = .single
            }
            var answers: [QuestionEntity.AnswerEntity] = []
            for i in 0...3 {
                var answer = QuestionEntity.AnswerEntity()
                answer.title = "阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性阳性报告制度阳性"
                answer.status = .defult
                if i == 2 {
                    answer.score = 5
                }
                answers.append(answer)
            }
            entity.answers = answers
            dataSource.append(entity)
        }
        self.mainView.setupData(data: dataSource)
    }
    
}
