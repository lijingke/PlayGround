//
//  QuestionEntity.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

struct QuestionEntity {
    var id: String?
    var sort: Int?
    var title: String?
    var answers: [AnswerEntity]?
    var type: QuestionType?
    var showAnswer = false
    
    struct AnswerEntity {
        var title: String?
        var status: AnswerStatus = .defult
        var score: Int = 0
        var sort: Int?
    }
}

enum AnswerStatus {
    case correct
    case wrong
    case defult
    case selected
}

enum QuestionType {
    case single
    case judge
    
    var text: String {
        switch self {
        case .single:
            return "单选题"
        case .judge:
            return "判断题"
        }
    }
}
