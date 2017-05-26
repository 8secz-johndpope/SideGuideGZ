//
//  WhoAreYouSocialDefault.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

enum WhoAreYouSocialDefault: Int, ChoiceSelectable {
    case leave_BLANK = -1
    case age_13U = 1
    case age_14_18 = 2
    case age_19_23 = 3
    case age_24_30 = 4
    case age_30O = 5
    
    func getButtonText() -> String {
        switch self {
        case .leave_BLANK: return "Leave Blank"
        case .age_13U: return "13 and Under"
        case .age_14_18: return "Between 14 and 18"
        case .age_19_23: return "Between 19 and 23"
        case .age_24_30: return "Between 24 and 30"
        case .age_30O: return "Over 30"
        }
    }
    
    func getSelectedText() -> String {
        switch self {
        case .leave_BLANK: return "Not giving age"
        case .age_13U: return "You're 13 or under"
        case .age_14_18: return "You're between 14 and 18"
        case .age_19_23: return "You're between 19 and 23"
        case .age_24_30: return "You're between 24 and 30"
        case .age_30O: return "You are over 30"
        }
    }
    
    static func getAllChoices() -> [ChoiceSelectable] {
        return [
            WhoAreYouSocialDefault.leave_BLANK,
            WhoAreYouSocialDefault.age_13U,
            WhoAreYouSocialDefault.age_14_18,
            WhoAreYouSocialDefault.age_19_23,
            WhoAreYouSocialDefault.age_24_30,
            WhoAreYouSocialDefault.age_30O
        ]
    }
    
    func getCategoryNumber() -> Int { return self.rawValue }
    
    func isEqualTo(_ other: ChoiceSelectable?) -> Bool {
        return self == (other as? WhoAreYouSocialDefault)
    }
}

