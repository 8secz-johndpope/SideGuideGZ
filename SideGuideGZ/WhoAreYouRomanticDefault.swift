
//
//  WhoAreYouRomanticDefault.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

enum WhoAreYouRomanticDefault: Int, ChoiceSelectable {
    
    case leave_BLANK = -1
    case straight_MALE = 1
    case straight_FEMALE = 2
    case gay = 3
    case lesbian = 4
    case other = 5
    
    func getButtonText() -> String {
        switch self {
        case .leave_BLANK: return "Leave Blank"
        case .straight_MALE: return "Straight Male"
        case .straight_FEMALE: return "Straight Female"
        case .gay: return "Gay"
        case .lesbian: return "Lesbian"
        case .other: return "Other"
        }
    }
    
    func getSelectedText() -> String {
        switch self {
        case .leave_BLANK: return "Leaving this blank"
        case .straight_MALE: return "You're a straight male"
        case .straight_FEMALE: return "You're a straight female"
        case .gay: return "You are gay"
        case .lesbian: return "You are lesbian"
        case .other: return "Your are other"
        }
    }
    
    static func getAllChoices() -> [ChoiceSelectable] {
        return [
            WhoAreYouRomanticDefault.leave_BLANK,
            WhoAreYouRomanticDefault.straight_MALE,
            WhoAreYouRomanticDefault.straight_FEMALE,
            WhoAreYouRomanticDefault.gay,
            WhoAreYouRomanticDefault.lesbian,
            WhoAreYouRomanticDefault.other
        ]
    }
    
    func getCategoryNumber() -> Int { return self.rawValue }
    
    func isEqualTo(_ other: ChoiceSelectable?) -> Bool {
        return self == (other as? WhoAreYouRomanticDefault)
    }
}

