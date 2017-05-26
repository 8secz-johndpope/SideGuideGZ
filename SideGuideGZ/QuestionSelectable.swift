//
//  QuestionSelectable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

protocol QuestionSelectable: ContextIdentifiable {
    func getText()->String
    func getChoices()->[ChoiceSelectable]
    static func getAllQuestions()->[QuestionSelectable]
}

