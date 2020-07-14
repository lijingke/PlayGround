//
//  FinalEvaluationInterface.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/22.
//  Copyright © 2020 李京珂. All rights reserved.
//

import Foundation

protocol FinalEvaluationProtocol: NSObject {
    func submitData(data: [QuestionEntity], autoJump: Bool, usedTime: Int)
    func jumpToResult()
}

protocol EvaluationEndViewProtocol: NSObject {
    func jumpToResult()
}

protocol EvaluationResultViewProtocol: NSObject {
    func retest()
    func back()
}
