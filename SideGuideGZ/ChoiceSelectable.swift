//
//  ChoiceSelectable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

protocol ChoiceSelectable {
    func getButtonText() -> String
    func getSelectedText() -> String
    func isEqualTo(_ other: ChoiceSelectable?) -> Bool
    func getCategoryNumber() -> Int
    static func getAllChoices()->[ChoiceSelectable]
}

