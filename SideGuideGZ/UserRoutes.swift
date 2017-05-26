//
//  UserRoutes.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/25/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

class UserRoutes {

    static func updateDefaultFirstQuestion(romantic: Int?, social: Int?, professional: Int?, vc: CrowdismaVC?, completion: ERROR_COMP) {
        let body = [
            "romantic" : String(romantic ?? -1),
            "professional" : String(professional ?? -1),
            "social" : String(social ?? -1)
        ]
        RequestManager.singleton.runPost(url: UserURLs.UPDATE_DEFAULT_FIRST_QUESTION, body: body, vc: vc) { (error, data) in
            if completion != nil {
                completion!(error)
            }
        }
    }
    
    static func getUserByID(id: String, vc: CrowdismaVC, completion: ERROR_USER_COMP) {
        let headers = ["user_id" : id]
        RequestManager.singleton.runGet(url: UserURLs.GET_USER_BY_ID, headers: headers, vc: vc) { (error, data) in
            if let comp = completion {
                if let err = error {
                    comp(err, nil)
                    return
                }
                if let rawUser = (data as! NSDictionary).object(forKey:"user") {
                    let user = User(dataEntered: rawUser as AnyObject)
                    comp(nil, user)
                } else {
                    comp(Error.unknown_ERROR, nil)
                }
            }
        }
    }
    
    static func getCurrentUser(_ vc: CrowdismaVC, completion: ERROR_USER_COMP) {
        RequestManager.singleton.runGet(url: UserURLs.GET_USER_FROM_TOKEN, headers: [:], vc: vc) { (error, data) in
            if let comp = completion {
                if let err = error {
                    comp(err, nil)
                    return
                }
                if let rawUser = (data as! NSDictionary).object(forKey: "user") {
                    let user = User(dataEntered: rawUser as AnyObject)
                    RequestManager.singleton.currentUser = user
                    comp(nil, user)
                } else {
                    comp(Error.unknown_ERROR, nil)
                }
            }
        }    
    }

}
