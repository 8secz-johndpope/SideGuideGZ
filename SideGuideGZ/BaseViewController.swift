//
//  BaseViewController.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, CrowdismaVC {

    // MARK: Popup Variables
    // fadeView and popView will show the different background view.
    internal var fadeView: UIView!
    internal var popupView: UIView!
    internal var onCloseCompletion: (() -> Void)?
    internal var popupNotVisible: NSLayoutConstraint!
    internal var popupVisible: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignConstants.THEME_GRAY
    }
    
    func displayLoginSignUp() {
        print("DISPLAY LOGIN SIGNUP CALLED")
        assert(false)
    }
    
    // lazy stored property is a property whose value is not calculated until the first time it 
    // is used.
    lazy var _marginLarge: CGFloat = {
        return UIScreen.main.bounds.size.height * LayoutConstants.LARGE_MARGIN_PROP
    }()
    
    lazy var _marginSmall: CGFloat = {
        return UIScreen.main.bounds.size.height * LayoutConstants.SMALL_MARGIN_PROP
    }()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return DesignConstants.STATUS_BAR_STYLE
    }

}
