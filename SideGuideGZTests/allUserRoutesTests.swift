//
//  allUserRoutesTests.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/25/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import XCTest
@testable import SideGuideGZ

class allUserRoutesTests: XCTestCase {
    
    fileprivate var testingVC: CrowdismaVC! = nil
    fileprivate let STANDARD_TIMEOUT = 15.0
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        testingVC = PhonyVC()
        let expec = self.expectation(description: "Need to login first. Doing that here.")
        AuthRoutes.login(email: "tester@gmail.com", password: "1234", vc: testingVC) { (error, user) in
            UserRoutes.updateDefaultFirstQuestion(romantic: -1, social: -1, professional: -1, vc: self.testingVC, completion: { (error) in
                expec.fulfill()
            })
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
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

    func test_getCurrentUser() {
        let expec = expectation(description: "Get Current User.")
        UserRoutes.getCurrentUser(testingVC) { (error, user) in
            XCTAssertNotNil(RequestManager.singleton.token)
            XCTAssertNil(error, error.debugDescription)
            XCTAssertNotNil(user)
            XCTAssert(user!.username == "tester")
            XCTAssert(user!.email == "tester@gmail.com")
            XCTAssert(user!.fqRomantic == -1)
            XCTAssert(user!.fqSocial == -1)
            XCTAssert(user!.fqProfessional == -1)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_getUserByIDInvalidID() {
        let expec = expectation(description: "Get invalid id")
        UserRoutes.getUserByID(id: "578fdfbc3ed6d0e30d65b620", vc: testingVC) { (error, user) in
            XCTAssertNotNil(error, error.debugDescription)
            XCTAssertNil(user)
            XCTAssertEqual(error, SideGuideGZ.Error.user_NOT_FOUND)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_getUserByIDShouldWork() {
        let expec = expectation(description: "Get user by id")
        UserRoutes.getUserByID(id: RequestManager.singleton.currentUser!._id, vc: testingVC) { (error, user) in
            XCTAssertNil(error)
            XCTAssertNotNil(user)
            XCTAssertEqual(user!.email, "tester@gmail.com")
            XCTAssertEqual(user!._id, RequestManager.singleton.currentUser!._id)
            expec.fulfill()
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
    
    func test_setDefaultsShouldWork() {
        let expec = expectation(description: "Setting defaults")
        UserRoutes.updateDefaultFirstQuestion(romantic: 3, social: 5, professional: 7, vc: testingVC) { (error) in
            XCTAssertNil(error)
            UserRoutes.getCurrentUser(self.testingVC, completion: { (error, user) in
                XCTAssertEqual(user!.fqProfessional, 7)
                XCTAssertEqual(user!.fqSocial, 5)
                XCTAssertEqual(user!.fqRomantic, 3)
                expec.fulfill()
            })
        }
        waitForExpectations(timeout: STANDARD_TIMEOUT, handler: nil)
    }
}
