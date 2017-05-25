//
//  SignUpLoginTextField.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class SignUpLoginTextField: BaseTextField {

    var inset: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setup()
    }
    
    fileprivate func _setup() {
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = DesignConstants.THEME_BACKGROUND
        layer.masksToBounds = false
        addShadow()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
        
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
