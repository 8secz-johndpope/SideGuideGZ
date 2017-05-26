//
//  UserURLs.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/25/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

enum UserURLs: String, URLUsable {
    
    case GET_USER_FROM_TOKEN = "getUserFromToken"
    case GET_USER_BY_ID = "getUserByID"
    case UPDATE_DEFAULT_FIRST_QUESTION = "updateDefaultFirstQuestions"
    
    
    func isPost() -> Bool {
        switch self {
        case .GET_USER_FROM_TOKEN: return false
        case .GET_USER_BY_ID: return false
        case .UPDATE_DEFAULT_FIRST_QUESTION: return true
        }
    }
    
    func getURLRequestWithMethod() -> NSMutableURLRequest {
        let urlString = RequestManager.singleton.getTokenizedURL("user/" + rawValue)
        let mURLRequest = NSMutableURLRequest(url: URL(string: urlString)!)
        if isPost() {
            mURLRequest.httpMethod = "POST"
            mURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            mURLRequest.httpMethod = "GET"
        }
        return mURLRequest    
    }
    
    func convertMutableURLRequest(mutableRequest: NSMutableURLRequest)->URLRequest {
        return mutableRequest.copy() as! URLRequest
    }
}
