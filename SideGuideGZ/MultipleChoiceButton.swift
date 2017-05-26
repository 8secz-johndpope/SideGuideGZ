//
//  MultipleChoiceButton.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

internal class MultipleChoiceButton: UIButton, MCExpandableContractable {

    var choice: ChoiceSelectable!
    fileprivate var closedConstraint: NSLayoutConstraint!
    fileprivate var expandedConstraint: NSLayoutConstraint!
    
    override var isHighlighted: Bool {
        didSet {
            guard !isSelected else { return }
            backgroundColor = (isHighlighted) ? DesignConstants.THEME_SECONDARY : DesignConstants.THEME_PRIMARY
        }
    }
    
    func setChoiceAndInitApperance(choice choiceToSet: ChoiceSelectable) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.zPosition = 1
        backgroundColor = DesignConstants.THEME_PRIMARY
        choice = choiceToSet
        setTitle(choice.getButtonText(), for: UIControlState())
        setTitleColor(DesignConstants.THEME_BACKGROUND, for: UIControlState())
        isHidden = true
        layer.cornerRadius = DesignConstants.DEFAULT_CORNER_RADUIS
    }
    
    func putOpenAndClosedConstraints(expanded: NSLayoutConstraint, closed: NSLayoutConstraint) {
        closedConstraint = closed
        expandedConstraint = expanded
    }
    
    func wasClosed() { isHidden = true }
    
    func expand() {
        closedConstraint.isActive = false
        expandedConstraint.isActive = true
    }
    
    func contract() {
        expandedConstraint.isActive = false
        closedConstraint.isActive = true
    }
    
    func prepForExpand() { isHidden = false }
    
    func setSeletedAppearance(setIsSelected: Bool) {
        isSelected = setIsSelected
        backgroundColor = setIsSelected ? DesignConstants.THEME_SECONDARY : DesignConstants.THEME_PRIMARY
    }

}
