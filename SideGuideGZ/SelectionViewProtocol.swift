
//
//  SelectionViewProtocol.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation
import UIKit

internal protocol SelectionViewProtocol: class {
    
    func getIsExpanded()->Bool
    func getSelectedChoice()->ChoiceSelectable?
    
    func setQuestion(question: QuestionSelectable)
    func setDelegate(delegate: SelectorManager)
    
    func putOpenAndClosedHeightConstraints(
        openConstraint openContraint: NSLayoutConstraint,
        closedConstraint closedContstraint: NSLayoutConstraint
    )
    func putOnOffScreenConstraints(onScreen on: NSLayoutConstraint, offScreen off: NSLayoutConstraint)
    
    func runExpandAnimation(completion: (()->())?)
    func runContractAnimation(completion: (()->Void)?)
    
    func moveOnScreen()
    func moveOffScreen()
    func callLayoutIfNeeded()
}
