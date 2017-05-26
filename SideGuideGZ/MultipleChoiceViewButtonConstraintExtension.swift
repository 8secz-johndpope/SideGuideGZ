//
//  MultipleChoiceViewButtonConstraintExtension.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation
import UIKit

extension MultipleChoiceSelectionView {
    internal func getHeightConstraintForButton(button: UIView)->NSLayoutConstraint {
        return NSLayoutConstraint(
            item: button, attribute: .height, relatedBy: .equal,
            toItem: questionLabel, attribute: .height,
            multiplier: 1, constant: 0
        )
    }
    
    internal func getWidthConstraintForButton(button: UIView)->NSLayoutConstraint {
        return NSLayoutConstraint(
            item: button, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width,
            multiplier: 1, constant: -(SelectorConstants.PADDING_ON_SIDES_OF_BUTTON * 2)
        )
    }
    
    internal func getTopConstraintForExpanedButton(button: UIView, idx: Int)->NSLayoutConstraint {
        return NSLayoutConstraint(
            item: button, attribute: .top, relatedBy: .equal,
            toItem: questionLabel, attribute: .bottom,
            multiplier: CGFloat(idx + 1), constant: CGFloat(idx + 1) * gapInBetweenElements
        )
    }
    
    internal func getTopConstraintForClosedButton(button: UIView)->NSLayoutConstraint {
        return NSLayoutConstraint(
            item: button, attribute: .top, relatedBy: .equal,
            toItem: questionLabel, attribute: .top,
            multiplier: 1, constant: 0
        )
    }
    
    internal func getCenterConstraintForButton(button: UIView)->NSLayoutConstraint {
        return button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    }
    
    internal func getOffscreenConstraint(button: UIView)->NSLayoutConstraint {
        return NSLayoutConstraint(
            item: button, attribute: .right, relatedBy: .equal,
            toItem: self, attribute: .left,
            multiplier: 1, constant: 0
        )
    }
}
