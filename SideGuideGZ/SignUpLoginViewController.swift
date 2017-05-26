//
//  SignUpLoginViewController.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class SignUpLoginViewController: BaseViewController, UITextFieldDelegate {

    // property are strong by default here.
    var isSignup = true
    var logoLabel: UILabel!
    var usernameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var moveOnButton: MoveOnButton!
    
    var logoActiveConstraint: NSLayoutConstraint!
    var logoHiddenConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignConstants.THEME_PRIMARY
        // Do any additional setup after loading the view.
        addElements()
    }

    fileprivate func addElements() {
        addLogoLabel()
        if isSignup {
            addUsernameTextField()
        }
        addEmailTextField()
        addPasswordTextField()
        addMoveOnButton()
        addOtherAuthOptionsButton()
    }
    
    fileprivate func addEmailTextField() {
        emailTextField = SignUpLoginTextField()
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.addTarget(
            self, action: #selector(SignUpLoginViewController.textDidChangeOnTextField(_:)),
            for: UIControlEvents.editingChanged
        )
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        constrainCenter(emailTextField)
        constrainTextFieldWidth(emailTextField)
        
        if isSignup {
            let emailTopToUsername = NSLayoutConstraint(
                item: emailTextField, attribute: .top, relatedBy: .equal,
                toItem: usernameTextField, attribute: .bottom,
                multiplier: 1, constant: _marginSmall
            )
            emailTopToUsername.isActive = true
        } else {
            let emailTopToLogo = NSLayoutConstraint(
                item: emailTextField, attribute: .top, relatedBy: .equal,
                toItem: logoLabel, attribute: .bottom,
                multiplier: 1, constant: _marginLarge
            )
            emailTopToLogo.isActive = true
        }
    }
    
    fileprivate func addLogoLabel() {
        logoLabel = LogoTitleLabel()
        view.addSubview(logoLabel)
        constrainCenter(logoLabel)
        logoActiveConstraint = NSLayoutConstraint(
            item: logoLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: _marginLarge // _marginLarge from Base View Controller
        )
        logoActiveConstraint.isActive = true
        logoHiddenConstraint = NSLayoutConstraint(
            item: logoLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )
    }
    
    fileprivate func addMoveOnButton() {
        moveOnButton = MoveOnButton()
        view.addSubview(moveOnButton)
        moveOnButton.setup(superView: view, aboveView: passwordTextField)
        moveOnButton.addTarget(
            self, action: #selector(SignUpLoginViewController.moveOnButtonPressed(_:)),
            for: .touchUpInside
        )
    }
    
    fileprivate func addPasswordTextField() {
        passwordTextField = SignUpLoginTextField()
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.addTarget(
            self, action: #selector(SignUpLoginViewController.textDidChangeOnTextField(_:)),
            for: UIControlEvents.editingChanged
        )
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        constrainCenter(passwordTextField)
        constrainTextFieldWidth(passwordTextField)
        let passwordTopToEmail = NSLayoutConstraint(
            item: passwordTextField, attribute: .top, relatedBy: .equal,
            toItem: emailTextField, attribute: .bottom,
            multiplier: 1, constant: _marginSmall
        )
        passwordTopToEmail.isActive = true
    }
    
    fileprivate func addOtherAuthOptionsButton() {
        let otherOptionsButton = OtherAuthOptionsButton()
        view.addSubview(otherOptionsButton)
        otherOptionsButton.setup(isInSignup: isSignup, superview: view)
        otherOptionsButton.addTarget(
            self, action: #selector(SignUpLoginViewController.otherOptionsPressed(_:)),
            for: .touchUpInside
        )
    }
    
    fileprivate func addUsernameTextField() {
        usernameTextField = SignUpLoginTextField()
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        usernameTextField.addTarget(
            self,
            action: #selector(SignUpLoginViewController.textDidChangeOnTextField(_:)),
            for: UIControlEvents.editingChanged)
        
        usernameTextField.placeholder = "Username"
        constrainCenter(usernameTextField)
        constrainTextFieldWidth(usernameTextField)
        let usernameTextFieldTop = NSLayoutConstraint(
            item: usernameTextField, attribute: .top, relatedBy: .equal,
            toItem: logoLabel, attribute: .bottom,
            multiplier: 1, constant: _marginLarge
        )
        usernameTextFieldTop.isActive = true
    }
    
    fileprivate func constrainCenter(_ viewToContrain: UIView) {
        let centConstraint = viewToContrain.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centConstraint.isActive = true
    }
    
    fileprivate func constrainTextFieldWidth(_ textField: UIView) {
        let widthConstraint = NSLayoutConstraint(
            item: textField, attribute: .width, relatedBy: .equal,
            toItem: view, attribute: .width,
            multiplier: LayoutConstants.TEXT_FIELD_WIDTH_PROP, constant: 0
        )
        widthConstraint.isActive = true
    }

    func textDidChangeOnTextField(_ textField: UITextField) {
        if isFormValid() {
            if !moveOnButton.isActive {
                moveMoveOnButton(moveOn: true)
            }
        } else {
            if moveOnButton.isActive {
                moveMoveOnButton(moveOn: false)
            }
        }
    }
    
    fileprivate func isFormValid() -> Bool {
        if isSignup {
            return usernameTextField.isFilled() && emailTextField.isFilled() && passwordTextField.isFilled()
        } else {
            return emailTextField.isFilled() && passwordTextField.isFilled()
        }
    }
    
    func otherOptionsPressed(_: UIButton) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpLogin") as! SignUpLoginViewController
        vc.isSignup = !isSignup
        // show method in iOS 8.0 will show a view controller appropriately.
        show(vc, sender: self)
    }
    
    func moveOnButtonPressed(_: UIButton) {
        submitForm()
    }
    
    fileprivate func submitForm() {
        view.endEditing(true)
        moveLogo(moveOn: true)
        addLoadingPopup() // Added Loading view
        let callback = { (error: Error?, user: User?) -> Void in
            
            ThreadingConstants.GlobalMainQueue.async(execute: {
                self.hardClose()
                
                if self.isSignup {
                    self.performSegue(withIdentifier: "ToQuestions", sender: self)
                } else {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
                    self.present(vc, animated: true, completion: nil)
                }
                
//                if let err = error {
//                    self.addErrorPopup(err, hardOpen: true, completion: {
//                        var textFieldToChange: UITextField? = nil
//                        if err == Error.sign_UP_EMAIL_EXISTS ||
//                            err == Error.sign_UP_INVALID_EMAIL ||
//                            err == Error.login_INVALID_EMAIL {
//                            textFieldToChange = self.emailTextField
//                            
//                        } else if err == Error.login_WRONG_PASSWORD {
//                            textFieldToChange = self.passwordTextField
//                        } else if err == Error.sign_UP_USERNAME_EXISTS {
//                            textFieldToChange = self.usernameTextField
//                        }
//                        if textFieldToChange != nil {
//                            textFieldToChange!.becomeFirstResponder()
//                            textFieldToChange!.selectedTextRange = textFieldToChange!.textRange(
//                                from: textFieldToChange!.beginningOfDocument, to: textFieldToChange!.endOfDocument
//                            )
//                        }
//                    })
//                } else {
//                    if self.isSignup {
//                        self.performSegue(withIdentifier: "ToQuestions", sender: self)
//                    } else {
//                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
//                        self.present(vc, animated: true, completion: nil)
//                    }
//                }
            })
        }
        
        if isSignup {
            AuthRoutes.signup(
                email: emailTextField.text!, username: usernameTextField.text!,
                password: passwordTextField.text!, vc: self, completion: callback
            )
        } else {
            AuthRoutes.login(
                email: emailTextField.text!, password: passwordTextField.text!,
                vc: self, completion: callback
            )
        }
    }
    
    fileprivate func moveMoveOnButton(moveOn: Bool) {
        UIView.animate(withDuration: AnimationConstants.DEFAULT_LONG_DISTANCE, animations: {
            if moveOn {
                self.moveOnButton.moveOnScreen()
            } else {
                self.moveOnButton.moveOffScreen()
            }
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.moveOnButton.isEnabled = moveOn
        })
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isFormValid() {
            submitForm()
        } else {
            if isSignup && !usernameTextField.isFilled() {
                usernameTextField.becomeFirstResponder()
            } else if !emailTextField.isFilled() {
                emailTextField.becomeFirstResponder()
            } else {
                passwordTextField.becomeFirstResponder()
            }
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = isFormValid() ? .go : .next
        moveLogo(moveOn: false)
    }
    
    fileprivate func moveLogo(moveOn: Bool) {
        UIView.animate(withDuration:AnimationConstants.DEFAULT_MEDUIM_DISTANCE) { 
            if moveOn {
                guard self.logoHiddenConstraint.isActive else {
                    return
                }
                // Make sure hidden constraint run first
                self.logoHiddenConstraint.isActive = false
                self.logoActiveConstraint.isActive = true
            } else {
                guard self.logoActiveConstraint.isActive else {
                    return
                }
                // Make sure active constraint run first
                self.logoActiveConstraint.isActive = false
                self.logoHiddenConstraint.isActive = true
            }
            // The line below is necessary for updating layout constraints.
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        moveLogo(moveOn: true)
        view.endEditing(true)
    }
    
}
