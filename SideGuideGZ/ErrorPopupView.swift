//
//  ErrorPopupView.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class ErrorPopupView: BasePopup {
    
    weak var delegate: BaseViewController!
    var error: Error!

    init(errorToDisplay: Error, delegateToUse: BaseViewController) {
        super.init(frame: CGRect.zero)
        error = errorToDisplay
        delegate = delegateToUse
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assert(false, "This initializer should not be used")
    }
    
    fileprivate func _setup() {
        addItems()
    }

    fileprivate func addItems() {
        let logoLabel = LogoTitleLabel()
        addSubview(logoLabel)
        logoLabel.addPrimaryColorText("Error")
        let logoCenterConstraint = logoLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        let logoTopConstraint = NSLayoutConstraint(
            item: logoLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top,
            multiplier: 1, constant: _marginLarge
        )
        setMaxWidthContraint(logoLabel)
        NSLayoutConstraint.activate([
            logoCenterConstraint,
            logoTopConstraint,
            ])
        
        let errorMessage = GeneralTextLabel()
        addSubview(errorMessage)
        errorMessage.text = error.getDisplayDescription()
        let errorCenterConstraint = errorMessage.centerXAnchor.constraint(equalTo: centerXAnchor)
        let errorTopConstraint = NSLayoutConstraint(
            item: errorMessage, attribute: .top, relatedBy: .equal,
            toItem: logoLabel, attribute: .bottom,
            multiplier: 1, constant: _marginSmall
        )
        setMaxWidthContraint(errorMessage)
        NSLayoutConstraint.activate([
            errorCenterConstraint,
            errorTopConstraint
            ])
        
        let okayButton = GeneralButton()
        addSubview(okayButton)
        okayButton.layer.zPosition = 20
        okayButton.isUserInteractionEnabled = true
        okayButton.addTarget(self, action: #selector(ErrorPopupView.okayButtonPressed), for: .touchUpInside)
        okayButton.setTitle("Okay", for: UIControlState())
        let okayButtonCenterContraint = okayButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let okayButtonTopContraint = NSLayoutConstraint(
            item: okayButton, attribute: .top, relatedBy: .equal,
            toItem: errorMessage, attribute: .bottom,
            multiplier: 1, constant: _marginLarge
        )
        let okayButtonBottomConstraint = NSLayoutConstraint(
            item: okayButton, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom,
            multiplier: 1, constant: -_marginLarge
        )
        NSLayoutConstraint.activate([
            okayButtonCenterContraint,
            okayButtonTopContraint,
            okayButtonBottomConstraint
            ])
        layoutIfNeeded()
    }
    
    // target method.
    func okayButtonPressed() {
        delegate.close()
    }
}
