//
//  GeneralButton.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class GeneralButton: BaseButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }

    fileprivate func _setup() {
        setTitleColor(DesignConstants.THEME_PRIMARY, for: UIControlState())
        setTitleColor(DesignConstants.THEME_SECONDARY, for: .highlighted)
    }
    
}
