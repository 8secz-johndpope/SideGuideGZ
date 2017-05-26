//
//  MultipleChoiceSelectionView.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

internal class MultipleChoiceSelectionView: UIView, SelectionViewProtocol {

    fileprivate var selectedChoice: ChoiceSelectable? = nil
    fileprivate var delegate: SelectorManager!
    fileprivate var question: QuestionSelectable!
    
    internal var questionLabel: QuestionLabel!
    
    fileprivate var isExpanded = false
    fileprivate var multipleChoiceButtons = [MultipleChoiceButton]()
    
    fileprivate var constraintForOpen: NSLayoutConstraint!
    fileprivate var constraintForClose: NSLayoutConstraint!
    fileprivate var constraintForOnScreen: NSLayoutConstraint!
    fileprivate var constraintForOffScreen: NSLayoutConstraint!
    
    fileprivate var buttonSelected: MultipleChoiceButton? = nil
    fileprivate var choiceSelectedLabel: ChoiceSelectedLabel? = nil
    
    
    var gapInBetweenElements: CGFloat {
        return UIScreen.main.bounds.height * SelectorConstants.PROPORTION_OF_SCREEN_HEIGHT_FOR_GAP
    }
    
    func setQuestion(question inputQuestion: QuestionSelectable) {
        setAppearance()
        question = inputQuestion
        questionLabel = QuestionLabel()
        addSubview(questionLabel)
        questionLabel.setQuestionAndInitApperance(question: question)
        setConstraintsOnQuestionLabel()
        let toggleFrameTopGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MultipleChoiceSelectionView.questionPressed(_:)))
        questionLabel.addGestureRecognizer(toggleFrameTopGestureRecognizer)
        setupButtons()
        isExpanded = false
    }
    
    fileprivate func setConstraintsOnQuestionLabel() {
        let leadingConstraint = NSLayoutConstraint(
            item: questionLabel, attribute: NSLayoutAttribute.leading, relatedBy: .equal,
            toItem: self, attribute: .leading,
            multiplier: 1.0, constant: 0
        )
        let labelTopConstraint = NSLayoutConstraint(
            item: questionLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top,
            multiplier: 1, constant: gapInBetweenElements
        )
        let heightConstraint = NSLayoutConstraint(
            item: questionLabel, attribute: .height, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute,
            multiplier: 1, constant: self.bounds.height - (2 * gapInBetweenElements)
        )
        let widthConstraint = NSLayoutConstraint(item: questionLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let offScreenConstraint = self.getOffscreenConstraint(button: questionLabel)
        questionLabel.putOnAndOffScreenConstraints(onScreen: [leadingConstraint], offScreen: offScreenConstraint)
        NSLayoutConstraint.activate([
            heightConstraint,
            labelTopConstraint,
            heightConstraint,
            leadingConstraint,
            widthConstraint
            ])
    }
    
    func runExpandAnimation(completion: (() -> Void)?) {
        let totalButtonMoveTime = SelectorConstants.TOTAL_BUTTON_MOVE_TIME
        let totalTime: TimeInterval = totalButtonMoveTime
        for button in multipleChoiceButtons { button.prepForExpand() }
        UIView.animateKeyframes(withDuration: totalTime, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: { () -> Void in
            if self.buttonSelected != nil {
                let slideOutDuration = SelectorConstants.SLIDE_QUESTION_LABEL_OUT_TIME / totalTime
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: slideOutDuration, animations: { () -> Void in
                    self.questionLabel.moveOnScreen()
                    self.layoutIfNeeded()
                })
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: { () -> Void in
                self.constraintForClose.isActive = false
                self.constraintForOpen.isActive = true
                self.delegate.layoutIfNeeded()
            })
            let reletiveTotalButtonMoveTime = totalButtonMoveTime / totalTime
            let baseButtonMoveTime = (totalButtonMoveTime / Double(self.multipleChoiceButtons.count)) / totalTime
            for (idx, mcView) in self.multipleChoiceButtons.enumerated() {
                let duration = Double(idx + 1) * baseButtonMoveTime
                let startTime = 0 + (reletiveTotalButtonMoveTime - duration)
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration, animations: { () -> Void in
                    mcView.expand()
                    self.layoutIfNeeded()
                })
            }
        }) { (_) -> Void in
            self.choiceSelectedLabel?.removeFromSuperview()
            if let comp = completion { comp() }
        }
        isExpanded = true
    }
    
    func runContractAnimation(completion: (()->Void)?) {
        let totalButtonMoveTime = SelectorConstants.TOTAL_BUTTON_MOVE_TIME
        let totalTime: TimeInterval = totalButtonMoveTime
        if self.buttonSelected != nil {
            choiceSelectedLabel = ChoiceSelectedLabel()
            let questionPressedGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MultipleChoiceSelectionView.questionPressed(_:)))
            choiceSelectedLabel!.addGestureRecognizer(questionPressedGestureRecognizer)
            addSubview(self.choiceSelectedLabel!)
            choiceSelectedLabel!.setWithTextAndViews(
                text: buttonSelected!.choice.getSelectedText(),
                superView: self,
                questionLabel: questionLabel
            )
            layoutIfNeeded()
        }
        delegate.disableUserInteraction()
        UIView.animateKeyframes(withDuration: totalTime, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: { () -> Void in
            let baseButtonMoveTime = (totalButtonMoveTime / Double(self.multipleChoiceButtons.count)) / totalTime
            for (idx, mcView) in self.multipleChoiceButtons.enumerated() {
                let duration = Double(idx + 1) * baseButtonMoveTime
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: { () -> Void in
                    mcView.contract()
                    self.layoutIfNeeded()
                })
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: { () -> Void in
                self.constraintForOpen.isActive = false
                self.constraintForClose.isActive = true
                self.delegate.layoutIfNeeded()
            })
            if self.buttonSelected != nil {
                let slideOutDuration = SelectorConstants.SLIDE_QUESTION_LABEL_OUT_TIME / totalTime
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: slideOutDuration, animations: { () -> Void in
                    self.questionLabel.moveOffScreen()
                    self.layoutIfNeeded()
                })
            }
        }) { (_) -> Void in
            for button in self.multipleChoiceButtons { button.wasClosed() }
            self.delegate.enableUserInteraction()
            if let comp = completion { comp() }
        }
        isExpanded = false
    }
    
    func getIsExpanded() -> Bool { return self.isExpanded }
    
    func getSelectedChoice() -> ChoiceSelectable? { return selectedChoice }
    
    func setDelegate(delegate: SelectorManager) { self.delegate = delegate }
    
    func chioceSelected(_ button: MultipleChoiceButton) {
        buttonSelected = button
        button.setSeletedAppearance(setIsSelected: true)
        for b in multipleChoiceButtons where b !== button {
            b.setSeletedAppearance(setIsSelected:  false)
        }
        let wasAlreadySelected = !button.choice.isEqualTo(selectedChoice)
        selectedChoice = button.choice
        delegate.requestContract(mcView: self, valueChanged: wasAlreadySelected)
    }
    
    func questionPressed(_ label: UILabel) {
        if isExpanded { delegate.requestContract(mcView: self, valueChanged: false) }
        else { delegate.requestExpand(mcView: self) }
    }
    
    internal func putOpenAndClosedHeightConstraints(openConstraint openContraint: NSLayoutConstraint, closedConstraint closedContstraint: NSLayoutConstraint) {
        constraintForOpen = openContraint
        constraintForClose = closedContstraint
    }
    
    internal func putOnOffScreenConstraints(onScreen on: NSLayoutConstraint, offScreen off: NSLayoutConstraint) {
        constraintForOnScreen = on
        constraintForOffScreen = off
    }
    
    fileprivate func setupButtons() {
        for (idx, choice) in question.getChoices().enumerated() {
            let choiceButton = MultipleChoiceButton()
            addSubview(choiceButton)
            let centerConstraint = getCenterConstraintForButton(button: choiceButton)
            let heightConstraint = getHeightConstraintForButton(button: choiceButton)
            let widthConstraint = getWidthConstraintForButton(button: choiceButton)
            let expandedTopConstraint = getTopConstraintForExpanedButton(button: choiceButton, idx: idx)
            let closedTopConstraint = getTopConstraintForClosedButton(button: choiceButton)
            choiceButton.addTarget(self, action: #selector(MultipleChoiceSelectionView.chioceSelected(_:)), for: UIControlEvents.touchUpInside)
            NSLayoutConstraint.activate([
                centerConstraint,
                heightConstraint,
                widthConstraint,
                closedTopConstraint
                ])
            choiceButton.putOpenAndClosedConstraints(
                expanded: expandedTopConstraint,
                closed: closedTopConstraint
            )
            choiceButton.setChoiceAndInitApperance(choice: choice)
            multipleChoiceButtons.append(choiceButton)
            choiceButton.layoutIfNeeded()
        }
    }
    
    internal func moveOnScreen() {
        constraintForOffScreen.isActive = false
        constraintForOnScreen.isActive = true
    }
    
    internal func moveOffScreen() {
        constraintForOnScreen.isActive = false
        constraintForOffScreen.isActive = true
    }
    
    internal func callLayoutIfNeeded() { layoutIfNeeded() }
    
    fileprivate func setAppearance() {
        backgroundColor = DesignConstants.THEME_BACKGROUND
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1.5
    }

}
