//
//  MiscUtils.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/25/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation
@testable import SideGuideGZ

class PhonyVC: CrowdismaVC {
    
    func displayLoginSignUp() {
        print("Displaying login and signup")
    }
}

func getDateNum() -> Double {
    return Date().timeIntervalSince1970
}
