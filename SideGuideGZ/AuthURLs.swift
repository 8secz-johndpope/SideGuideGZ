//
//  AuthURLs.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

enum AuthURLs: String, URLUsable {
    case LOGIN = "login"
    case SIGN_UP = "signup"
 
    func isPost() -> Bool {
        switch self {
        case .LOGIN:
            return true
        case .SIGN_UP:
            return true
        }
    }
    
    func getURLRequestWithMethod() -> NSMutableURLRequest {
        let urlString = APIConstants.BASE_URL + rawValue
        let mURLRequest = NSMutableURLRequest(url: URL(string: urlString)!)
        mURLRequest.httpMethod = "POST"
        mURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return mURLRequest
    }
    
    
    func convertMutableURLRequest(mutableRequest: NSMutableURLRequest)->URLRequest {
        return mutableRequest.copy() as! URLRequest
    }
    
    
}
