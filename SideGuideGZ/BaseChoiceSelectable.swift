//
//  BaseChoiceSelectable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//


protocol BaseChoiceSelectable: ChoiceSelectable {
    func getQuestionsForChoice()->[QuestionSelectable]
}
