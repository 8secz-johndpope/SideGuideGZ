//
//  DesignConstants.swift
//  Crowdisma
//
//  Created by Anthony Dito on 7/30/16.
//  Copyright © 2016 Dito Enterprises. All rights reserved.
//

import UIKit

struct DesignConstants {
    //Colors
    static let THEME_PRIMARY = UIColor(red:0.10, green:0.21, blue:0.32, alpha:1.00)
    static let THEME_SECONDARY = UIColor(red:0.23, green:0.41, blue:0.67, alpha:1)
    static let THEME_BACKGROUND = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
    static let THEME_GRAY = UIColor(red:0.81, green:0.81, blue:0.81, alpha:1)
    static let THEME_TEXT = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1.00)
    static let FINAL_POPOVER_FADE_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
    static let START_POPOVER_FADE_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    //Shadow
    static let BASE_SHADOW_OPACITY: Float = 0.37
    static let DEFAULT_SHADOW_RADIUS: CGFloat = 3
    static let DEFAULT_SHADOW_OFFSET: CGSize = CGSize(width: 3, height: 3)
    
    //Other
    static let DEFAULT_CORNER_RADUIS: CGFloat = 3
    static let STATUS_BAR_STYLE: UIStatusBarStyle = UIStatusBarStyle.lightContent
}
