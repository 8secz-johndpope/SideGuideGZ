//
//  SetDefaultQuestionsViewController.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class SetDefaultQuestionsViewController: BaseViewController, SelectorUserable {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var selectorManager: SelectorManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startQuestion = "To make you experience with this app better. Please answer these demographic questions... Or, skip. You're choice."
        selectorManager.initForSelection(baseQuestion: nil,
                                         questions: GetDefaultAnswersQuestion.getAllQuestions(),
                                         startQuestion: startQuestion,
                                         delegateToUse: self)
    }
    
    func selectorSkip() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        present(vc, animated: true, completion: nil)
    }
    
    func selectorMoveOn(answers: [ChoiceSelectable]) {
        var fqProfessional = -1, fqSocial = -1, fqRomantic = -1
        for answer in answers {
            let answerContext = GetDefaultAnswersQuestion.getContext(choice: answer)
            switch answerContext {
            case .professional:
                fqProfessional = answer.getCategoryNumber()
            case .social:
                fqSocial = answer.getCategoryNumber()
            case .romantic:
                fqRomantic = answer.getCategoryNumber()
            case .notAContext:
                assert(false, "Not an attribute should not be returned by this here. It is setting the defaults")
            }
        }
        addLoadingPopup()
        UserRoutes.updateDefaultFirstQuestion(romantic: fqRomantic, social: fqSocial, professional: fqProfessional, vc: nil) { (error) in
            (ThreadingConstants.GlobalMainQueue).async(execute: {
                if (error == nil) {
                    self.close({
                        //this is where i should move on
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
                        self.present(vc, animated: true, completion: nil)
                    })
                } else {
                    self.hardClose()
                    self.addErrorPopup(error!, hardOpen: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func cancelPressed(_ sender: AnyObject) {
        selectorSkip()
    }

}
