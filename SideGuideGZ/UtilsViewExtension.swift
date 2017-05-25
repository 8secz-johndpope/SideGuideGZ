//
//  UtilsViewExtension.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

extension UIView {
    
    var _marginLarge: CGFloat {
        return UIScreen.main.bounds.size.height * LayoutConstants.LARGE_MARGIN_PROP
    }
    
    var _marginSmall: CGFloat {
        return UIScreen.main.bounds.size.height * LayoutConstants.SMALL_MARGIN_PROP
    }
    
    func addShadow() {
        layer.cornerRadius = DesignConstants.DEFAULT_CORNER_RADUIS
        layer.shadowOffset = DesignConstants.DEFAULT_SHADOW_OFFSET
        layer.shadowRadius = DesignConstants.DEFAULT_SHADOW_RADIUS
        layer.shadowOffset = DesignConstants.DEFAULT_SHADOW_OFFSET
        layer.shadowOpacity = DesignConstants.BASE_SHADOW_OPACITY
    }

}
