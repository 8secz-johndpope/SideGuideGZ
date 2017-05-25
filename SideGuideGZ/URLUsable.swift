//
//  URLUsable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

protocol URLUsable {
    func isPost() -> Bool
    func getURLRequestWithMethod() -> NSMutableURLRequest
    func convertMutableURLRequest(mutableRequest: NSMutableURLRequest)->URLRequest
}
