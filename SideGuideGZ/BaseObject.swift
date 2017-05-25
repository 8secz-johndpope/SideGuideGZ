//
//  BaseObject.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class BaseObject {
    
    internal var data: AnyObject
    
    lazy var createdAt: Date = self.getDateFromData(isUpdatedAt: false)

    var _id:String {
        get {
            return data.object(forKey:"_id") as! String
        }
    }
    
    init(dataEntered:AnyObject) {
        data = dataEntered
    }
    
    internal func getDateFromData(isUpdatedAt: Bool)->Date {
        let dateFormatter = DateFormatter()
        let keyName = isUpdatedAt ? "updatedAt" : "createdAt"
        let createdAtTime = self.data.object(forKey: keyName)! as! String
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ"
        return dateFormatter.date(from: createdAtTime)!
    }
    
}
