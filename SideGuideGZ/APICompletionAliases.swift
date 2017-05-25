//
//  APICompletionAliases.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

typealias ERROR_COMP = ((_ error: Error?) -> Void)?
typealias ERROR_DATA_COMP = (_ error: Error?, _ data: AnyObject?) -> Void
typealias ERROR_USER_COMP = ((_ error: Error?, _ user: User?) -> Void)?
