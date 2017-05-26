
//
//  SelectorUserable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

protocol SelectorUserable {
    func selectorMoveOn(answers: [ChoiceSelectable]) -> Void
    func selectorSkip()
}
