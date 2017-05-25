//
//  SignUpTests.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/25/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import XCTest
@testable import SideGuideGZ

class SignUpTests: XCTestCase {
    
    fileprivate let STANDARD_TIMEOUT = 15.0
    
    fileprivate var testingVC: CrowdismaVC! = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
    func test_signUpNotAllInformation1() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "", username: "", password: "", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.info_WRONG)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_signUpNotAllInformation2() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "anthonymdito@gmail.com", username: "dito", password: "", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.info_WRONG, "the info was not wrong")
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_signUpNotAllInformation3() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "", username: "dito",password: "1234", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.info_WRONG)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_invalidEmail1() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "a", username: "dito", password: "1234", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.sign_UP_INVALID_EMAIL)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_invalidEmail2() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "a@", username: "dito", password: "1234", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.sign_UP_INVALID_EMAIL)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_invalidEmail3() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "a@d", username: "dito", password: "1234", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.sign_UP_INVALID_EMAIL)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_invalidEmail4() {
        let expec = self.expectation(description: "Testing not all info")
        AuthRoutes.signup(email: "a@d.", username: "dito", password: "1234", vc: testingVC) { (error, user) in
            XCTAssert(error == Crowdisma.Error.sign_UP_INVALID_EMAIL)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_userAlreadyExists() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        let t = Date().timeIntervalSince1970
        let uniqueEmail = "uniqueEmail_\(t)@r.com"
        let password = "12345"
        AuthRoutes.signup(email: uniqueEmail, username: "dito\(t)", password: password, vc: testingVC) { (error, user) in
            XCTAssertNil(error)
            AuthRoutes.signup(email: uniqueEmail, username: "dito1\(t)", password: password, vc: self.testingVC)  { (error, user) in
                XCTAssert(error == Crowdisma.Error.sign_UP_EMAIL_EXISTS)
                expec.fulfill()
            }
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_shouldWork() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        let t = Date().timeIntervalSince1970
        let uniqueEmail = "uniqueEmail_\(t)@r.com"
        let password = "12345"
        AuthRoutes.signup(email: uniqueEmail, username: "unique_username\(t)", password: password, vc: testingVC) { (error, user) in
            XCTAssertNil(error)
            XCTAssertNotNil(RequestManager.singleton.token)
            XCTAssertNotNil(RequestManager.singleton.currentUser)
            XCTAssert(RequestManager.singleton.currentUser?.points == 0)
            XCTAssert(RequestManager.singleton.currentUser?.email == uniqueEmail)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
}
