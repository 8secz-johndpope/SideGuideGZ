//
//  SelectorManager.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class SelectorManager: UIView {

    fileprivate var questions: [QuestionSelectable]?
    fileprivate var selectionViews = [SelectionViewProtocol]()
    fileprivate var baseQuestion: QuestionSelectable?
    fileprivate var baseQuestionView: SelectionViewProtocol?
    fileprivate var openView: SelectionViewProtocol? = nil
    
    fileprivate var moveOnButton: MoveOnButton? = nil
    
    fileprivate var startQuestionLabel: StartQuestionLabel?
    fileprivate var startQuestionGoButton: MoveOnButton?
    fileprivate var startQuestionSkipButton: MoveOnButton?
    
    fileprivate var delegate: SelectorUserable!
    
    fileprivate var numberOfQuestions: Int {
        var temp = questions?.count ?? 0
        temp += baseQuestion != nil ? 1 : 0
        return temp
    }
    
    fileprivate var openHeightProportion: CGFloat {
        let totalClosedProportions = SelectorConstants.PROPORTION_OF_SCREEN_HEIGHT_FOR_CLOSED_SELECTION_VIEW * CGFloat(numberOfQuestions - 1)
        return 1.0 - totalClosedProportions - SelectorConstants.PROPORTION_OF_SCREEN_WIDTH_UNFILLED_FOR_SELECTOR
    }
    
    func initForSelection(baseQuestion bq: QuestionSelectable?, questions questionsToAdd: [QuestionSelectable]?, startQuestion sq: String?, delegateToUse: SelectorUserable) {
        delegate = delegateToUse
        setApperance()
        setGestureRecognizer()
        questions = questionsToAdd
        baseQuestion = bq
        if sq != nil {
            showStartQuestion(sq!)
        } else {
            setBasedOnBaseQuestion()
        }
    }
    
    fileprivate func showStartQuestion(_ startQuestion: String) {
        startQuestionLabel = StartQuestionLabel()
        addSubview(startQuestionLabel!)
        startQuestionLabel!.setQuestionAndInitApperance(questionText: startQuestion)
        let baseGap = UIScreen.main.bounds.height * 0.025
        let labelTopContraint = NSLayoutConstraint(
            item: startQuestionLabel!, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top,
            multiplier: 1, constant: baseGap
        )
        let labelCenterContraint = startQuestionLabel!.centerXAnchor.constraint(equalTo: centerXAnchor)
        let labelLeftContraint = NSLayoutConstraint(
            item: startQuestionLabel!, attribute: .left, relatedBy: .equal,
            toItem: self, attribute: .left,
            multiplier: 1, constant: baseGap
        )
        NSLayoutConstraint.activate([
            labelTopContraint,
            labelCenterContraint,
            labelLeftContraint
            ])
        startQuestionGoButton = MoveOnButton()
        addSubview(startQuestionGoButton!)
        startQuestionGoButton!.setup(superView: self, aboveView: nil, text: "Okay")
        let okayCenter = NSLayoutConstraint(
            item: startQuestionGoButton!, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX,
            multiplier: 0.65, constant: 0
        )
        let okayTop = NSLayoutConstraint(
            item: startQuestionGoButton!, attribute: .top, relatedBy: .equal,
            toItem: startQuestionLabel!, attribute: .bottom,
            multiplier: 1, constant: baseGap
        )
        NSLayoutConstraint.activate([
            okayTop,
            okayCenter
            ])
        startQuestionGoButton!.addTarget(self, action: #selector(SelectorManager._questionsApproved), for: .touchUpInside)
        startQuestionSkipButton = MoveOnButton()
        addSubview(startQuestionSkipButton!)
        startQuestionSkipButton!.setup(superView: self, aboveView: nil, text: "Skip")
        let skipCenter = NSLayoutConstraint(
            item: startQuestionSkipButton!, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX,
            multiplier: 1.35, constant: 0
        )
        let skipTop = NSLayoutConstraint(
            item: startQuestionSkipButton!, attribute: .top, relatedBy: .equal,
            toItem: startQuestionLabel!, attribute: .bottom,
            multiplier: 1, constant: baseGap
        )
        NSLayoutConstraint.activate([
            skipCenter,
            skipTop
            ])
        startQuestionSkipButton!.addTarget(self, action: #selector(SelectorManager._skipPressed), for: .touchUpInside)
        layoutIfNeeded()
    }
    
    func _skipPressed() {
        delegate.selectorSkip()
    }
    
    func _questionsApproved() {
        UIView.animate(withDuration: SelectorConstants.FADE_IN_TIME_FOR_CONTEXT_VIEW, animations: {
            self.startQuestionGoButton?.alpha = 0
            self.startQuestionLabel?.alpha = 0
            self.startQuestionSkipButton?.alpha = 0
        }, completion: { (_) in
            self.startQuestionSkipButton?.removeFromSuperview()
            self.startQuestionLabel?.removeFromSuperview()
            self.startQuestionGoButton?.removeFromSuperview()
            self.setBasedOnBaseQuestion()
        })
    }
    
    fileprivate func setBasedOnBaseQuestion() {
        if baseQuestion == nil {
            setQuestions(startPreviousView: nil)
        } else {
            let mcView = MultipleChoiceSelectionView()
            mcView.translatesAutoresizingMaskIntoConstraints = false
            mcView.setDelegate(delegate: self)
            baseQuestionView = mcView
            addSubview(mcView)
            setConstraints(mcView, previousView: nil, openHieghtConstraintProportion: 0.6)
            mcView.setQuestion(question: baseQuestion!)
            mcView.moveOnScreen()
            mcView.isHidden = false
            layoutIfNeeded()
            mcView.alpha = 0.0
            UIView.animate(withDuration: SelectorConstants.FADE_IN_TIME_FOR_CONTEXT_VIEW, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                mcView.alpha = 1.0
                self.layoutIfNeeded()
            }, completion: {(_) -> Void in
                self.requestExpand(mcView: mcView)
            })
        }
    }
    
    fileprivate func setQuestions(startPreviousView spv: UIView?) {
        var previousView: UIView? = spv
        for question in questions! {
            let mcView = MultipleChoiceSelectionView()
            mcView.translatesAutoresizingMaskIntoConstraints = false
            mcView.setDelegate(delegate: self)
            selectionViews.append(mcView)
            addSubview(mcView)
            setConstraints(mcView, previousView: previousView)
            mcView.setQuestion(question: question)
            previousView = mcView
        }
        //        layoutIfNeeded() // this line caused issues on the animations... might need it though
        let moveNumbers = getMoveTimes()
        disableUserInteraction()
        UIView.animateKeyframes(withDuration: moveNumbers.totalTime, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: { () -> Void in
            for (idx, sv) in self.selectionViews.enumerated() {
                let startTime = moveNumbers.startTimes[idx] / moveNumbers.totalTime
                let duration = moveNumbers.durations[idx] / moveNumbers.totalTime
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration, animations: { () -> Void in
                    sv.moveOnScreen()
                    sv.callLayoutIfNeeded()
                })
            }
        }, completion: { (_) -> Void in
            if let vToOpen = self.findToOpenNext(excludeView: nil) {
                self.requestExpand(mcView: vToOpen)
            }
            self.enableUserInteraction()
        })
    }
    
    fileprivate func removeOldQuestionsAndInsertNew(_ questionsToAdd: [QuestionSelectable]) {
        let moveNumbers = getMoveTimes(reversed: true)
        disableUserInteraction()
        layoutIfNeeded()
        UIView.animateKeyframes(withDuration: moveNumbers.totalTime, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: { () -> Void in
            for (idx, sv) in self.selectionViews.enumerated() {
                let startTime = moveNumbers.startTimes[idx] / moveNumbers.totalTime
                let duration = moveNumbers.durations[idx] / moveNumbers.totalTime
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration, animations: { () -> Void in
                    sv.moveOffScreen()
                    sv.callLayoutIfNeeded()
                })
            }
        }) { (_) -> Void in
            for view in self.selectionViews { (view as! UIView).removeFromSuperview() }
            self.questions = questionsToAdd
            self.selectionViews = []
            self.setQuestions(startPreviousView: (self.baseQuestionView! as! UIView))
        }
    }
    
    fileprivate func getMoveTimes(reversed: Bool = false)->(startTimes: [Double], durations: [Double], totalTime: Double) {
        var startTimes = [Double]()
        var durations = [Double]()
        let startPosition = baseQuestionView == nil ? 0 : 1
        var previousStartTime = 0.0
        var previousDuration = 0.0
        let timeForFullScreenMove: TimeInterval = SelectorConstants.TIME_FOR_FULL_SCREEN_MOVE_ON_QUESTION
        for i in startPosition ..< numberOfQuestions {
            let proportionOfViewAsHeight = (CGFloat(i) * SelectorConstants.PROPORTION_OF_SCREEN_HEIGHT_FOR_CLOSED_SELECTION_VIEW) / self.bounds.height
            let totalDistanceToTravel = 1.0 - proportionOfViewAsHeight
            let duration = Double(totalDistanceToTravel) * timeForFullScreenMove
            let startTime = previousStartTime + (previousDuration / 2)
            startTimes.append(startTime)
            durations.append(duration)
            previousDuration = duration
            previousStartTime = startTime
        }
        let totalTime = previousStartTime + previousDuration
        if reversed {
            startTimes = startTimes.reversed()
            durations = durations.reversed()
        }
        return (startTimes: startTimes, durations: durations, totalTime: totalTime)
    }
    
    internal func requestExpand(mcView: SelectionViewProtocol) {
        if moveOnButton != nil { moveMoveOnButtonOffScreenAndDelete() }
        if let mcViewOpen = openView {
            mcViewOpen.runContractAnimation(completion: { () -> Void in
                mcView.runExpandAnimation(completion: nil)
            })
        } else { mcView.runExpandAnimation(completion: nil) }
        openView = mcView
    }
    
    internal func requestContract(mcView: SelectionViewProtocol, valueChanged: Bool = true) {
        if mcView === baseQuestionView && questions == nil, let baseQuestionSelectedChoice = baseQuestionView!.getSelectedChoice() as? BaseChoiceSelectable {
            questions = baseQuestionSelectedChoice.getQuestionsForChoice()
            mcView.runContractAnimation(completion: { () -> Void in
                self.setQuestions(startPreviousView: (mcView as! UIView))
            })
        } else if mcView === baseQuestionView && questions != nil && valueChanged, let baseQuestionSelectedChoice = baseQuestionView!.getSelectedChoice() as? BaseChoiceSelectable {
            let questionsToAdd = baseQuestionSelectedChoice.getQuestionsForChoice()
            mcView.runContractAnimation(completion: { () -> Void in
                self.removeOldQuestionsAndInsertNew(questionsToAdd)
            })
        } else if let viewToExpand = findToOpenNext(excludeView: mcView) {
            mcView.runContractAnimation(completion: { () -> Void in
                viewToExpand.runExpandAnimation(completion: nil)
            })
            openView = viewToExpand
        } else {
            mcView.runContractAnimation(completion: { () -> Void in
                if mcView.getSelectedChoice() != nil { self.addMoveOnButton() }
            })
            openView = nil
        }
    }
    
    fileprivate func findToOpenNext(excludeView: SelectionViewProtocol?)->SelectionViewProtocol? {
        for mcView in selectionViews where mcView !== excludeView {
            if mcView.getSelectedChoice() == nil {
                return mcView
            }
        }
        return nil
    }
    
    fileprivate func setConstraints(_ viewWorking: SelectionViewProtocol, previousView: UIView?, openHieghtConstraintProportion: CGFloat? = nil) {
        if let viewToConstrain = viewWorking as? UIView {
            let closedHeightConstraint = NSLayoutConstraint(
                item: viewToConstrain,
                attribute: .height,
                relatedBy: .equal,
                toItem: self,
                attribute: .height,
                multiplier: SelectorConstants.PROPORTION_OF_SCREEN_HEIGHT_FOR_CLOSED_SELECTION_VIEW,
                constant: 0
            )
            var openHeightConstraint: NSLayoutConstraint! = nil
            if let ohcp = openHieghtConstraintProportion {
                openHeightConstraint = NSLayoutConstraint(item: viewToConstrain, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ohcp, constant: 0.0)
            } else {
                openHeightConstraint = NSLayoutConstraint(
                    item: viewToConstrain, attribute: .height, relatedBy: .equal,
                    toItem: self, attribute: .height,
                    multiplier: openHeightProportion, constant: 0
                )
            }
            let offScreenConstraint = NSLayoutConstraint(
                item: viewToConstrain, attribute: .top, relatedBy: .equal,
                toItem: self, attribute: .bottom,
                multiplier: 1, constant: 0
            )
            var topConstraint: NSLayoutConstraint! = nil
            if previousView != nil {
                topConstraint = NSLayoutConstraint(
                    item: viewToConstrain, attribute: .top, relatedBy: .equal,
                    toItem: previousView!, attribute: .bottom,
                    multiplier: 1, constant: 0
                )
            } else {
                topConstraint = NSLayoutConstraint(
                    item: viewToConstrain, attribute: .top, relatedBy: .equal,
                    toItem: self, attribute: .top,
                    multiplier: 1, constant: 0
                )
            }
            closedHeightConstraint.isActive = true
            NSLayoutConstraint.activate([
                viewToConstrain.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                viewToConstrain.leftAnchor.constraint(equalTo: self.leftAnchor),
                offScreenConstraint,
                closedHeightConstraint
                ])
            viewWorking.putOpenAndClosedHeightConstraints(openConstraint: openHeightConstraint, closedConstraint: closedHeightConstraint)
            viewWorking.putOnOffScreenConstraints(onScreen: topConstraint, offScreen: offScreenConstraint)
            viewToConstrain.layoutIfNeeded()
        } else {
            assert(false, "the view passed into this function was not a UIView... That should not of happened.")
        }
    }
    
    fileprivate func addMoveOnButton() {
        moveOnButton = MoveOnButton()
        addSubview(moveOnButton!)
        moveOnButton!.setup(superView: self, aboveView: selectionViews.last! as? UIView) // made untest change of as! to as?
        layoutIfNeeded()
        moveOnButton!.addTarget(self, action: #selector(SelectorManager.moveOnButtonPressed(_:)), for: .touchUpInside)
        moveMoveOnButtonOnScreen()
    }
    
    internal func moveOnButtonPressed(_ button: UIButton) {
        var returnArr = [ChoiceSelectable]()
        for view in selectionViews {
            returnArr.append(view.getSelectedChoice()!)
        }
        delegate.selectorMoveOn(answers: returnArr)
    }
    
    fileprivate func moveMoveOnButtonOnScreen() {
        UIView.animate(withDuration: SelectorConstants.MOVING_MOVE_ON_BUTTON_TIME, animations: { () -> Void in
            self.moveOnButton!.moveOnScreen()
            self.layoutIfNeeded()
        }, completion: { (_) -> Void in
            self.moveOnButton!.isEnabled = true
        })
    }
    
    fileprivate func moveMoveOnButtonOffScreenAndDelete() {
        self.moveOnButton!.isEnabled = false
        UIView.animate(withDuration: SelectorConstants.TOTAL_BUTTON_MOVE_TIME, animations: { () -> Void in
            self.moveOnButton!.moveOffScreen()
            self.layoutIfNeeded()
        }, completion: { (_) -> Void in
            self.moveOnButton!.removeFromSuperview()
            self.moveOnButton = nil
        })
    }
    
    func backgroundTouched(_ view: AnyObject) {
        return // NOT DOING ANYTHING ON BACKGROUND PRESS.
        //        if openView != nil { requestContract(mcView: openView!) }
    }
    
    fileprivate func setGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SelectorManager.backgroundTouched(_:)))
        addGestureRecognizer(recognizer)
    }
    
    fileprivate func setApperance() {
        self.backgroundColor = DesignConstants.THEME_GRAY
    }
    
    internal func enableUserInteraction() {
        isUserInteractionEnabled = true
    }
    
    internal func disableUserInteraction() {
        isUserInteractionEnabled = false
    }
}
