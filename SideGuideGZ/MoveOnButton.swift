//
//  MoveOnButton.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class MoveOnButton: BaseButton {
    
    fileprivate var onScreenConstraint: NSLayoutConstraint!
    fileprivate var offScreenConstraint: NSLayoutConstraint!
    
    fileprivate let _widthProp: CGFloat = 0.25
    
    var isActive: Bool {
        return onScreenConstraint.isActive
    }

    func moveOnScreen() {
        offScreenConstraint.isActive = false
        onScreenConstraint.isActive = true
    }
    
    func moveOffScreen() {
        onScreenConstraint.isActive = false
        offScreenConstraint.isActive = true
    }
    
    func setup(superView superViewToConstrain: UIView, aboveView: UIView?, text: String? = nil) {
        let title = text ?? "Go"
        setTitle(title, for: UIControlState())
        setTitle(title, for: .disabled)
        _setup()
        setWidthConstraint(superViewToConstrain)
        if aboveView != nil {
            setConstraints(superViewToConstrain, aboveView: aboveView!)
        } else {
            isEnabled = true
        }
    }
    
    fileprivate func setConstraints(_ superViewToConstrain: UIView, aboveView: UIView) {
        sizeToFit()
        let widthConstraint = NSLayoutConstraint(
            item: self, attribute: .width, relatedBy: .equal,
            toItem: superViewToConstrain, attribute: .width,
            multiplier: _widthProp, constant: 0
        )
        let centeredConstraint = centerXAnchor.constraint(equalTo: superViewToConstrain.centerXAnchor)
        onScreenConstraint = NSLayoutConstraint(
            item: self, attribute: .top, relatedBy: .equal,
            toItem: aboveView, attribute: .bottom,
            multiplier: 1, constant: superViewToConstrain.bounds.size.height * LayoutConstants.SMALL_MARGIN_PROP
        )
        offScreenConstraint = NSLayoutConstraint(
            item: self, attribute: .top, relatedBy: .equal,
            toItem: superViewToConstrain, attribute: .bottom,
            multiplier: 1, constant: 0
        )
        NSLayoutConstraint.activate([
            widthConstraint,
            offScreenConstraint,
            centeredConstraint
            ])
    }
    
    fileprivate func setWidthConstraint(_ viewToConstrain: UIView) {
        let widthConstraint = NSLayoutConstraint(
            item: self, attribute: .width, relatedBy: .equal,
            toItem: viewToConstrain, attribute: .width,
            multiplier: _widthProp, constant: 0
        )
        widthConstraint.isActive = true
        layoutIfNeeded()
    }
    
    fileprivate func _setup() {
        isEnabled = false
        backgroundColor = DesignConstants.THEME_SECONDARY
        addShadow()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.shadowOpacity = 0.0
            } else {
                layer.shadowOpacity = DesignConstants.BASE_SHADOW_OPACITY
            }
        }
    }
}
