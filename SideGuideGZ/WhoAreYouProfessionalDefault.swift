
//
//  WhoAreYouProfessionalDefault.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

enum WhoAreYouProfessionalDefault: Int, ChoiceSelectable {
    case leave_BLANK = -1
    case student = 1
    case just_STARTING_OUT = 2
    case lost = 3
    case on_THE_COME_UP = 4
    case where_I_WANT_TO_BE = 5
    
    func getButtonText() -> String {
        switch self {
        case .leave_BLANK: return "Leave Blank"
        case .student: return "Student"
        case .just_STARTING_OUT: return "Just starting out"
        case .lost: return "Lost"
        case .on_THE_COME_UP: return "On the come up"
        case .where_I_WANT_TO_BE: return "Were I want to be"
        }
    }
    
    func getSelectedText() -> String {
        switch self {
        case .leave_BLANK: return "I'm passing on this one"
        case .student: return "I'm a student"
        case .just_STARTING_OUT: return "I'm just starting out"
        case .lost: return "I'm lost"
        case .on_THE_COME_UP: return "I'm on the come up"
        case .where_I_WANT_TO_BE: return "I'm where I want to be"
        }
    }
    
    static func getAllChoices() -> [ChoiceSelectable] {
        return [
            WhoAreYouProfessionalDefault.leave_BLANK,
            WhoAreYouProfessionalDefault.student,
            WhoAreYouProfessionalDefault.just_STARTING_OUT,
            WhoAreYouProfessionalDefault.lost,
            WhoAreYouProfessionalDefault.on_THE_COME_UP,
            WhoAreYouProfessionalDefault.where_I_WANT_TO_BE
        ]
    }
    
    func getCategoryNumber() -> Int { return self.rawValue }
    
    func isEqualTo(_ other: ChoiceSelectable?) -> Bool {
        return self == (other as? WhoAreYouProfessionalDefault)
    }
}
