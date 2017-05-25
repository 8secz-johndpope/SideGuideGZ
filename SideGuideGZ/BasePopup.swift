//
//  BasePopup.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class BasePopup: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    fileprivate func _setup() {
        backgroundColor = DesignConstants.THEME_BACKGROUND
        translatesAutoresizingMaskIntoConstraints = false
        addShadow()
    }
    
    internal func setMaxWidthContraint(_ viewToContrain: UIView) {
        let maxWidthConstraint = NSLayoutConstraint(
            item: viewToContrain, attribute: .width, relatedBy: .lessThanOrEqual,
            toItem: self, attribute: .width,
            multiplier: LayoutConstants.POPUP_INTERIOR_MAX_WIDTH, constant: 0
        )
        maxWidthConstraint.isActive = true
    }
}
