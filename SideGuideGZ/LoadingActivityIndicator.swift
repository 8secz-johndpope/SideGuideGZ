//
//  LoadingActivityIndicator.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class LoadingActivityIndicator: UIActivityIndicatorView {

    init() {
        super.init(activityIndicatorStyle: .whiteLarge)
        _setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    fileprivate func _setup() {
        activityIndicatorViewStyle = .whiteLarge
        translatesAutoresizingMaskIntoConstraints = false
        color = DesignConstants.THEME_SECONDARY        
    }

}
