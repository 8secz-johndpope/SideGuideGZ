//
//  ThreadingConstants.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

struct ThreadingConstants {
    
    static var GlobalMainQueue: DispatchQueue {
        return DispatchQueue.main
    }
    
    static var GlobalUserInteractiveQueue: DispatchQueue {
        return DispatchQueue.global(qos: .userInteractive)
    }
    
    static var GlobalUserInitiatedQueue: DispatchQueue {
        return DispatchQueue.global(qos: .userInitiated)
    }
    
    static var GlobalUtilityQueue: DispatchQueue {
        return DispatchQueue.global(qos: .utility)
    }
    
    static var GlobalBackgroundQueue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }        
}
