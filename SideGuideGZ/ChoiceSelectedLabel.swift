//
//  ChoiceSelectedLabel.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

internal class ChoiceSelectedLabel: UILabel {

    fileprivate var offScreenConstraint: NSLayoutConstraint!
    fileprivate var onScreenConstraint: NSLayoutConstraint!
    
    func setWithTextAndViews(text textToSet: String, superView: UIView, questionLabel: UIView) {
        layer.zPosition = 2
        translatesAutoresizingMaskIntoConstraints = false
        text = textToSet
        numberOfLines = 1
        isUserInteractionEnabled = true
        font = self.font.withSize(SelectorConstants.QUESTION_LABEL_FONT_SIZE)
        isHidden = false
        textColor = DesignConstants.THEME_TEXT
        backgroundColor = DesignConstants.THEME_BACKGROUND
        setAllConstraints(superView: superView, questionLabel: questionLabel)
    }
    
    fileprivate func setAllConstraints(superView: UIView, questionLabel: UIView) {
        let widthConstraint = NSLayoutConstraint(
            item: self, attribute: .width, relatedBy: .equal,
            toItem: superView, attribute: .width,
            multiplier: 1, constant: 0
        )
        let heightConstraint = NSLayoutConstraint(
            item: self, attribute: .height, relatedBy: .equal,
            toItem: questionLabel, attribute: .height,
            multiplier: 1, constant: 0
        )
        let topConstraint = NSLayoutConstraint(
            item: self, attribute: .top, relatedBy: .equal,
            toItem: questionLabel, attribute: .top,
            multiplier: 1, constant: 0
        )
        
        let leftConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: questionLabel, attribute: .right, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint,
            topConstraint,
            leftConstraint
            ])
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

}
