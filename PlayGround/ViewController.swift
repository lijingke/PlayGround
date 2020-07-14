//
//  ViewController.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/7/14.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

struct BasicEntity {
    let title: String
    let vcName: String
}

class ViewController: UIViewController {
    
    // MARK: - Property
    let data: [BasicEntity] = {
        return [BasicEntity(title: "问卷调查", vcName: "QuestionnaireController"), BasicEntity(title: "终期评估模拟", vcName: "FinalEvaluationViewController"), BasicEntity(title: "终期评估考核", vcName: "EvaluationResultViewController"), BasicEntity(title: "禁止登陆", vcName: "DenyLoginViewController"), BasicEntity(title: "医生已离开", vcName: "DoctorLeftViewController"), BasicEntity(title: "PlayGround", vcName: "PlayGroundViewController")]
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Lazy Get
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
}

// MARK: - UI
extension ViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = data[indexPath.row].vcName
        
        if vcName == "FinalEvaluationViewController" {
            let vc = FinalEvaluationViewController(dataSource: creatData())
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if let vc = self.getVCFromString(vcName) {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let title = data[indexPath.row].title
        cell.textLabel?.text = title
        return cell
    }
    
    
}


extension ViewController {
    private func creatData() -> [QuestionEntity] {
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
                answer.title = "A. 阳性报告制度"
                answer.status = .defult
                if i == 2 {
                    answer.score = 5
                }
                answers.append(answer)
            }
            entity.answers = answers
            dataSource.append(entity)
        }
        return dataSource
    }
    
}
