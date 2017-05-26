
//
//  ContextIdentifiable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

protocol ContextIdentifiable {
    static func getContext(choice: ChoiceSelectable) -> CrowdismaContext
}
