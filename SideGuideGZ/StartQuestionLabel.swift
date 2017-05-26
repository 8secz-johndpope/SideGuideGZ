//
//  StartQuestionLabel.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class StartQuestionLabel: UILabel {

    func setQuestionAndInitApperance(questionText: String) {
        layer.zPosition = 2
        translatesAutoresizingMaskIntoConstraints = false
        text = questionText
        numberOfLines = 0
        isUserInteractionEnabled = true
        font = self.font.withSize(SelectorConstants.QUESTION_LABEL_FONT_SIZE)
        isHidden = false
        textColor = DesignConstants.THEME_TEXT
        backgroundColor = UIColor.clear
        textAlignment = NSTextAlignment.center
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
