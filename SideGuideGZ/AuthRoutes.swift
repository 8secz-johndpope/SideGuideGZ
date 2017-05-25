//
//  AuthRoutes.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

class AuthRoutes {
    
    static func login(email: String, password: String, vc: CrowdismaVC?, completion: ERROR_USER_COMP) {
        let body = ["email" : email, "password" : password]
        RequestManager.singleton.runPost(url: AuthURLs.LOGIN, body: body, vc: vc) { (error, data) in
            if let comp = completion {
                if let err = error {
                    comp(err, nil)
                    return
                }
                if let rawUser = data?.object(forKey: "user"), let token = data?.object(forKey: "token") as? String {
                    let user = User(dataEntered: rawUser as AnyObject)
                    RequestManager.singleton.token = token
                    RequestManager.singleton.currentUser = user
                    comp(nil, user)
                } else {
                    comp(Error.unknown_ERROR, nil)
                }
            }
        }
    }

    static func signup(email: String, username: String, password: String, vc: CrowdismaVC?, completion: ERROR_USER_COMP) {
        let body = ["email" : email, "password" : password, "username" : username]
        RequestManager.singleton.runPost(url: AuthURLs.SIGN_UP, body: body, vc: vc) { (error, data) in
            if let comp = completion {
                if let err = error {
                    comp(err, nil)
                    return
                }
                if let rawUser = data?.object(forKey: "user"), let token = data?.object(forKey: "token") as? String {
                    let user = User(dataEntered: rawUser as AnyObject)
                    RequestManager.singleton.token = token
                    RequestManager.singleton.currentUser = user
                    comp(nil, user)
                } else {
                    comp(Error.unknown_ERROR, nil)
                }
            }
        }
    }
}
