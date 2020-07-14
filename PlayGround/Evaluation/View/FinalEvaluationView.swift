//
//  FinalEvaluationView.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/22.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

class FinalEvaluationView: UIView {
    
    // MARK: - Property
    weak var delegate: FinalEvaluationProtocol?
    private var dataSource: [QuestionEntity] = []
    private var currentIndex: Int = 0
    private var killTimer: CountDownTimer!
    private var usedTime: Int = 0
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("FinalEvaluationView已销毁")
    }
    
    // MARK: - Lazy Get
    
    lazy var headView: FinalEvaluationHeaderView = {
        let view = FinalEvaluationHeaderView()
        return view
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF9F9F9)
        return view
    }()
    
    lazy var tableHeadView: FinalEvaluationTableHeader = {
        let header = FinalEvaluationTableHeader()
        return header
    }()
    
    lazy var footView: FinalEvaluationFootView = {
        let view = FinalEvaluationFootView()
        return view
    }()
    
    lazy var tableShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width:0, height:0)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5.0
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.register(FinalEvaluationQuesCell.self, forCellReuseIdentifier: FinalEvaluationQuesCell.identifer)
        table.register(FinalEvaluationChoiceAnswerCell.self, forCellReuseIdentifier: FinalEvaluationChoiceAnswerCell.identifer)
        table.register(FinalEvaluationJudgeAnswerCell.self, forCellReuseIdentifier: FinalEvaluationJudgeAnswerCell.identifer)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 100
        table.separatorStyle = .none
        table.layer.cornerRadius = 10
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    lazy var finishView: EvaluationEndView = {
        let view = EvaluationEndView()
        view.delegate = self
        return view
    }()
    
}

// MARK: - UI
extension FinalEvaluationView {
    
    private func setupUI() {
        self.backgroundColor = .white
        addSubview(headView)
        addSubview(backView)
        addSubview(tableShadowView)
        addSubview(tableView)
        
        let height = footView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.footView.frame
        frame.size.height = height
        footView.frame = frame
        footView.setNeedsLayout()
        tableView.tableFooterView = footView
        
        headView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(headView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
        tableShadowView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(95)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(tableView.tableFooterView!)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(tableShadowView)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        UIApplication.shared.windows.first?.addSubview(finishView)
        finishView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
}

// MARK: - UITableViewDelegate
extension FinalEvaluationView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if currentIndex >= dataSource.count {
            return UIView()
        }
        
        let entity = dataSource[currentIndex]
        let title = entity.type?.text ?? ""
        
        guard let answers = entity.answers else {
            return tableHeadView
        }
        
        var btnType: FinalEvaluationTableHeader.BtnType = entity.showAnswer ? .next : .comfirm
        
        let hasChoosed = answers.contains(where: {$0.status != .defult})
        
        let bingo = answers.contains(where: {$0.status == .correct}) && !answers.contains(where: {$0.status == .wrong})
        
        if hasChoosed == false || bingo {
            btnType = .hide
        }
        
        if currentIndex == dataSource.count - 1 && entity.showAnswer {
            btnType = .end
        }
        
        tableHeadView.setupData(title: title, btnType: btnType)
        
        tableHeadView.btnActionBlock = { [weak self] in
            self?.headBtnClicked(type: btnType)
        }
        return tableHeadView
    }
    
}

// MARK: - UITableViewDataSource
extension FinalEvaluationView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentIndex < dataSource.count {
            let entity = dataSource[currentIndex]
            let answersCount = entity.answers?.count ?? 0
            return answersCount + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentIndex < dataSource.count {
            var entity = dataSource[currentIndex]
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FinalEvaluationQuesCell.identifer, for: indexPath) as? FinalEvaluationQuesCell else {
                    return UITableViewCell()
                }
                cell.setupData(entity.title ?? "")
                return cell
            } else if entity.type == .some(.single) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FinalEvaluationChoiceAnswerCell.identifer, for: indexPath) as? FinalEvaluationChoiceAnswerCell else {
                    return UITableViewCell()
                }
                
                cell.isUserInteractionEnabled = !entity.showAnswer
                
                if let answer = entity.answers?[indexPath.row - 1] {
                    cell.setupData(entity: answer)
                }
                cell.clickBlock = { [weak self] (data) in
                    let count = entity.answers?.count ?? 0
                    for i in 0 ..< count {
                        entity.answers?[i].status = .defult
                    }
                    entity.answers?[indexPath.row - 1] = data
                    self?.dataSource[self?.currentIndex ?? 0] = entity
                    self?.tableView.reloadData()
                }
                return cell
            } else if entity.type == .some(.judge) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FinalEvaluationJudgeAnswerCell.identifer, for: indexPath) as? FinalEvaluationJudgeAnswerCell else {
                    return UITableViewCell()
                }
                
                cell.isUserInteractionEnabled = !entity.showAnswer
                
                if let answer = entity.answers?[indexPath.row - 1] {
                    cell.setupData(entity: answer)
                }
                cell.clickBlock = { [weak self] (data) in
                    let count = entity.answers?.count ?? 0
                    for i in 0 ..< count {
                        entity.answers?[i].status = .defult
                    }
                    entity.answers?[indexPath.row - 1] = data
                    self?.dataSource[self?.currentIndex ?? 0] = entity
                    self?.tableView.reloadData()
                }
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - DealData
extension FinalEvaluationView {
    
    public func setupData(data: [QuestionEntity]) {
        self.dataSource = data
        self.currentIndex = 0
        headView.setupProgress(current: currentIndex + 1, count: dataSource.count)
        timeStart()
        self.tableView.reloadData()
    }
    
    private func jumpToNextQuestion() {
        if currentIndex < dataSource.count {
            currentIndex += 1
            headView.setupProgress(current: currentIndex + 1, count: dataSource.count)
            tableView.reloadData()
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    public func headBtnClicked(type: FinalEvaluationTableHeader.BtnType) {
        switch type {
        case .hide:
            break
        case .comfirm:
            var entity = dataSource[currentIndex]
            entity.showAnswer = true
            
            // 改变答案状态
            let count = entity.answers?.count ?? 0
            for i in 0 ..< count {
                if entity.answers?[i].score ?? 0 > 0 {
                    entity.answers?[i].status = .correct
                }
                if entity.answers?[i].status == .some(.selected) {
                    if entity.answers?[i].score ?? 0 > 0 {
                        entity.answers?[i].status = .correct
                    } else {
                        entity.answers?[i].status = .wrong
                    }
                }
            }
            dataSource[currentIndex] = entity
            tableView.reloadData()
            
            if self.currentIndex == self.dataSource.count - 1 {
                return
            }
            
            if entity.answers?.contains(where: {$0.status == .wrong}) == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.jumpToNextQuestion()
                }
            }
        case .next:
            self.jumpToNextQuestion()
            break
        case .end:
            submiteData(autoJump: true, usedTime: self.usedTime)
            break
        }
    }
}

// MARK: - Event
extension FinalEvaluationView {
    
    private func submiteData(autoJump: Bool, usedTime: Int) {
        delegate?.submitData(data: self.dataSource, autoJump: autoJump, usedTime: usedTime)
    }
    
    // 开启计时器
    private func timeStart() {
        killTimer = CountDownTimer(seconds: 1201, callBack: {[weak self] (seconds) in
            let text = seconds.secondsToTimeString()
            let hourAndminute = text.suffix(5).replacingOccurrences(of: ":", with: "")
            let timeArray = hourAndminute.compactMap{$0}
            self?.usedTime = 1200 - seconds
            self?.headView.setupCountDown(timeArray)
            if hourAndminute == "0000" {
                self?.finishView.show()
                self?.submiteData(autoJump: false, usedTime: self?.usedTime ?? 0)
            }
        })
    }
}

// MARK: - EvaluationEndViewProtocol
extension FinalEvaluationView: EvaluationEndViewProtocol {
    func jumpToResult() {
        delegate?.jumpToResult()
    }
}

// MARK: - Timer
extension FinalEvaluationView {
  func pauseTimer() {
    killTimer.pause()
  }
  
  func reactivateTimer() {
    killTimer.reactivate()
  }
  
}

// MARK: - UIScrollViewDelegate
extension FinalEvaluationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = tableView.contentOffset
        if offset.y <= 0 {
            offset.y = 0
        }
        tableView.contentOffset = offset
    }
}
