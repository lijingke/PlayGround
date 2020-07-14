//
//  FinalEvaluationResultEntity.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/23.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

struct FinalEvaluationResultEntity {
    /// 总分
    var totalScore: Int = 0 {
        didSet {
            isPass = totalScore > 84
        }
    }
    /// 答对题目数
    var correctCount: Int = 0
    /// 打错题目数
    var wrongCount: Int = 0
    /// 未答题目数
    var unanswerCount: Int = 0
    /// 用时
    var usedTime: Int = 0
    /// 考试日期
    var examinationTime: String?
    /// 成绩
    var isPass: Bool = false
}
