//
//  LogoTitleLabel.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class LogoTitleLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    fileprivate func _setup() {
        font = FontConstants.THEME_HEADING
        translatesAutoresizingMaskIntoConstraints = false
        text = "Gong Zhen"
        textColor = DesignConstants.THEME_BACKGROUND
    }
    
    func addPrimaryColorText(_ addedText: String) {
        textColor = DesignConstants.THEME_PRIMARY
        text = addedText
    }
    
}
