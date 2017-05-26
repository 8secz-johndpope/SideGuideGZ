//
//  QuestionLabel.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

internal class QuestionLabel: UILabel, MCExpandableContractable {

    fileprivate var onScreenConstraints: [NSLayoutConstraint]!
    fileprivate var offScreenConstraint: NSLayoutConstraint!

    func setQuestionAndInitApperance(question: QuestionSelectable) {
        layer.zPosition = 2
        translatesAutoresizingMaskIntoConstraints = false
        text = question.getText()
        numberOfLines = 1
        isUserInteractionEnabled = true
        font = self.font.withSize(SelectorConstants.QUESTION_LABEL_FONT_SIZE)
        isHidden = false
        textColor = DesignConstants.THEME_TEXT
        backgroundColor = DesignConstants.THEME_BACKGROUND
    }
    
    func contract() { }
    
    func prepForExpand() {}
    
    func putOnAndOffScreenConstraints(onScreen: [NSLayoutConstraint], offScreen: NSLayoutConstraint) {
        onScreenConstraints = onScreen
        offScreenConstraint = offScreen
    }
    
    func moveOffScreen() {
        for c in onScreenConstraints { c.isActive = false }
        offScreenConstraint.isActive = true
    }
    
    func moveOnScreen() {
        offScreenConstraint.isActive = false
        for c in onScreenConstraints { c.isActive = true }
    }
    
    func expand() {}
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
}
