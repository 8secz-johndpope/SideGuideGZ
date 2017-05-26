//
//  GetDefaultAnswersQuestion.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

enum GetDefaultAnswersQuestion: QuestionSelectable {

    case romantic_CONTEXT
    case social_CONTEXT
    case professional_CONTEXT
    
    static func getContext(choice: ChoiceSelectable) -> CrowdismaContext {
        if choice is WhoAreYouProfessionalDefault {
            return CrowdismaContext.professional
        } else if choice is WhoAreYouSocialDefault {
            return CrowdismaContext.social
        } else if choice is WhoAreYouRomanticDefault {
            return CrowdismaContext.romantic
        } else {
            return CrowdismaContext.notAContext
        }
    }
    
    static func getAllQuestions() -> [QuestionSelectable] {
        return [
            GetDefaultAnswersQuestion.romantic_CONTEXT,
            GetDefaultAnswersQuestion.social_CONTEXT,
            GetDefaultAnswersQuestion.professional_CONTEXT
        ]
    }
    
    func getText() -> String {
        switch self {
        case .romantic_CONTEXT: return "How would you define yourself?"
        case .social_CONTEXT: return "How old are you?"
        case .professional_CONTEXT: return "Where are you professionally?"
        }
    }
    
    func getChoices() -> [ChoiceSelectable] {
        switch self {
        case .professional_CONTEXT: return WhoAreYouProfessionalDefault.getAllChoices()
        case .social_CONTEXT: return WhoAreYouSocialDefault.getAllChoices()
        case .romantic_CONTEXT: return WhoAreYouRomanticDefault.getAllChoices()
        }
    }    
}
