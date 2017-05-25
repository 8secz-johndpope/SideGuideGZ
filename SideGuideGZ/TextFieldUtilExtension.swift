//
//  TextFieldUtilExtension.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

extension UITextField {
    func isFilled() -> Bool {
        return (text?.characters.count)! > 0
    }
}
