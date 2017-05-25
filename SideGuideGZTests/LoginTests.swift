//
//  LoginTests.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/25/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import XCTest
@testable import SideGuideGZ

class LoginTests: XCTestCase {
    
    fileprivate let STANDARD_TIMEOUT = 15.0
    
    fileprivate var testingVC: CrowdismaVC! = nil
    
    override func setUp() {
        super.setUp()
        testingVC = PhonyVC()
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
    
    func test_loginNotAllInformation1() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        AuthRoutes.login(email: "", password: "", vc: testingVC) { (error, user) in
            XCTAssert(error == SideGuideGZ.Error.info_WRONG, error.debugDescription)
            XCTAssertNil(user)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_loginNotAllInformation2() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        AuthRoutes.login(email: "dito@rohan.sdsu.edu", password: "", vc: testingVC) { (error, user) in
            XCTAssert(error == SideGuideGZ.Error.info_WRONG)
            XCTAssertNil(user)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_loginNotAllInformation3() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        AuthRoutes.login(email: "", password: "sdfasdfasdf", vc: testingVC) { (error, user) in
            XCTAssert(error == SideGuideGZ.Error.info_WRONG)
            XCTAssertNil(user)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_invalidEmailOnLogin() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        AuthRoutes.login(email: "random_stuff_here", password: "sdfasdfasdf", vc: testingVC) { (error, user) in
            XCTAssert(error == SideGuideGZ.Error.login_INVALID_EMAIL, error.debugDescription)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_wrongPassword() {
        let expec = self.expectation(description: "Testing Creating of a comment")
        let t = getDateNum()
        let uniqueUsername = "uniqueUsername\(t)"
        let uniqueEmail = "uniqueEmail_\(t)@r.com"
        AuthRoutes.signup(email: uniqueEmail, username: uniqueUsername, password: "1234", vc: testingVC) { (error, user) in
            XCTAssertNil(error, error.debugDescription)
            AuthRoutes.login(email: uniqueEmail, password: "0000", vc: self.testingVC, completion: { (error, user) in
                XCTAssert(error == SideGuideGZ.Error.login_WRONG_PASSWORD, error.debugDescription)
                expec.fulfill()
            })
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
}
