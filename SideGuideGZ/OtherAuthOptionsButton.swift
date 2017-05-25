//
//  OtherAuthOptionsButton.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class OtherAuthOptionsButton: BaseButton {
    func setup(isInSignup: Bool, superview: UIView) {
        _setup()
        let text = isInSignup ? "Already have an account? Log in." :
        "Don't have an account? Sign up."
        setTitle(text, for: UIControlState())
        setConstraints(superview: superview)
    }
    
    fileprivate func setConstraints(superview: UIView) {
        let centerConstraint = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let bottomContraint = NSLayoutConstraint(
            item: self, attribute: .bottom, relatedBy: .equal,
            toItem: superview, attribute: .bottom,
            multiplier: 1, constant: 0
        )
        let leftConstraint = NSLayoutConstraint(
            item: self, attribute: .left, relatedBy: .equal,
            toItem: superview, attribute: .left,
            multiplier: 1, constant: 0
        )
        NSLayoutConstraint.activate([
            centerConstraint,
            bottomContraint,
            leftConstraint
            ])
        superview.layoutIfNeeded()        
    }
    
    fileprivate func _setup() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = FontConstants.THEME_HEADING_SMALL
        titleLabel?.textAlignment = .center
        setTitleColor(DesignConstants.THEME_BACKGROUND, for: UIControlState())
        backgroundColor = DesignConstants.THEME_SECONDARY
    }

}
