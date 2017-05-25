//
//  BaseTextField.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }
    
    fileprivate func _setup() {
        textColor = DesignConstants.THEME_TEXT
        tintColor = DesignConstants.THEME_SECONDARY
        font = FontConstants.THEME_TEXT
    }

}
