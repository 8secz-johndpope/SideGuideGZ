//
//  LoadingPopupView.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class LoadingPopupView: BasePopup {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    fileprivate func _setup() {
        addItems()
    }

    fileprivate func addItems() {
        let logoLabel = LogoTitleLabel()
        addSubview(logoLabel)
        logoLabel.addPrimaryColorText("Loading...")
        let logoCenterConstraint = logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let logoTopConstraint = NSLayoutConstraint(
            item: logoLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: _marginLarge
        )
        setMaxWidthContraint(logoLabel)
        NSLayoutConstraint.activate([
            logoCenterConstraint,
            logoTopConstraint,
        ])
        
        let activityView = LoadingActivityIndicator()
        activityView.startAnimating()
        addSubview(activityView)
        let activityCenterConstraint = activityView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let activityTopContraint = NSLayoutConstraint(
            item: activityView, attribute: .top, relatedBy: .equal,
            toItem: logoLabel, attribute: .bottom,
            multiplier: 1, constant: _marginLarge
        )
        let activityBottomContraint = NSLayoutConstraint(
            item: activityView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom,
            multiplier: 1, constant: -_marginLarge
        )
        NSLayoutConstraint.activate(
            [activityCenterConstraint,
             activityTopContraint,
             activityBottomContraint
            ])
        layoutIfNeeded()
    }
}
