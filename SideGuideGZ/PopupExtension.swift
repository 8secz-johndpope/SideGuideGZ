//
//  PopupExtension.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

extension BaseViewController : UIGestureRecognizerDelegate {
    
    // MARK: Public Interface
    
    func addLoadingPopup() {
        popupView = LoadingPopupView()
        runPopup(hardOpen: true)
    }
    
    func addErrorPopup(_ error: Error, hardOpen: Bool, completion: (() ->Void)?) {
        popupView = ErrorPopupView(errorToDisplay: error, delegateToUse: self)
        onCloseCompletion = completion // onCloseCompletion from BaseViewController
        runPopup(hardOpen: hardOpen)
    }
    
    func hardClose() {
        finishClose()
    }

    // MARK: Utils
    
    fileprivate func runPopup(hardOpen: Bool = false) {
        initFadeView()
        fadeView.addSubview(popupView)
        addPopupContraints()
        fadeBackground()
        if hardOpen {
            showPopup()
        } else {
            animatePopup()
        }
    }
    
    fileprivate func addPopupContraints() {
        popupView.layer.zPosition = 11
        let centerXConstraint = popupView.centerXAnchor.constraint(equalTo: fadeView.centerXAnchor)
        let widthConstraint = NSLayoutConstraint(
            item: popupView, attribute: .width, relatedBy: .equal,
            toItem: fadeView, attribute: .width,
            multiplier: LayoutConstants.POPUP_WIDTH, constant: 0
        )
        let maxHeightConstraint = NSLayoutConstraint(
            item: popupView, attribute: .height, relatedBy: .lessThanOrEqual,
            toItem: fadeView, attribute: .height,
            multiplier: LayoutConstants.POPUP_MAX_HEIGHT, constant: 0
        )
        popupNotVisible = NSLayoutConstraint(
            item: popupView, attribute: .top, relatedBy: .equal,
            toItem: fadeView, attribute: .bottom,
            multiplier: 1, constant: 0
        )
        popupVisible = NSLayoutConstraint(
            item: popupView, attribute: .centerY, relatedBy: .equal,
            toItem: fadeView, attribute: .centerY,
            multiplier: LayoutConstants.POPUP_CENTER_Y_MULT, constant: 0
        )
        popupView.centerYAnchor.constraint(equalTo: fadeView.centerYAnchor)
        NSLayoutConstraint.activate([
            popupNotVisible,
            centerXConstraint,
            widthConstraint,
            maxHeightConstraint
            ])
    }
    
    fileprivate func showPopup() {
        popupNotVisible.isActive = false
        popupVisible.isActive = true
        view.layoutIfNeeded()
    }
    
    fileprivate func animatePopup() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: AnimationConstants.POPOVER_ANIMATION, animations: {
            self.popupNotVisible.isActive = false
            self.popupVisible.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func initFadeView() {
        fadeView = UIView()
        fadeView.translatesAutoresizingMaskIntoConstraints = false
        fadeView.backgroundColor = DesignConstants.START_POPOVER_FADE_COLOR
        view.addSubview(fadeView)
        
        let topConstraint = fadeView.topAnchor.constraint(equalTo: view.topAnchor)
        let leftConstraint = fadeView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = fadeView.rightAnchor.constraint(equalTo: view.rightAnchor)
        let bottomConstraint = fadeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leftConstraint,
            rightConstraint,
            bottomConstraint
            ])
        view.layoutIfNeeded()
        let gesture = UITapGestureRecognizer(
            target: self, action: #selector(BaseViewController.backgroundPressed))
        gesture.delegate = self
        fadeView.addGestureRecognizer(gesture)
        fadeView.layer.zPosition = 10
    }

    fileprivate func fadeBackground() {
        UIView.animate(withDuration: AnimationConstants.POPOVER_ANIMATION, animations: {
            self.fadeView.backgroundColor = DesignConstants.FINAL_POPOVER_FADE_COLOR
            }
        )
    }

    func backgroundPressed() {
        if popupView is LoadingPopupView {
            return
        }
        close()
    }
    
    func close(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: AnimationConstants.POPOVER_ANIMATION, animations: {
            self.fadeView.backgroundColor = DesignConstants.START_POPOVER_FADE_COLOR
            self.popupVisible.isActive = false
            self.popupNotVisible.isActive = true
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.finishClose()
            if completion != nil { completion!() }
        })
    }
    
    fileprivate func finishClose() {
        fadeView.removeFromSuperview()
        popupView.removeFromSuperview()
        if onCloseCompletion != nil {
            onCloseCompletion!()
        }
        onCloseCompletion = nil
    }
    
    //MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: view)
        return !popupView.frame.contains(location)
    }
    
    
}
