//
//  Error.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

enum Error: Int {
    
    case unknown_ERROR = -1
    
    // Server Errors
    case token_NOT_PROVIDED = 1
    case token_AUTH_FAILED = 2
    case info_WRONG = 3
    case repeat_VOTE = 4
    case login_INVALID_EMAIL = 5
    case login_WRONG_PASSWORD = 6
    case sign_UP_INVALID_EMAIL = 7
    case sign_UP_USERNAME_EXISTS = 8
    case sign_UP_EMAIL_EXISTS = 9
    case user_NOT_FOUND = 10
    case repo_ENTRY_NOT_FOUND = 11
    case cannot_VOTE_ON_OWN_OBJECT = 12
    case repo_ENTRY_COMMENT_NOT_FOUND = 13
    case judge_ENTRY_NOT_FOUND = 14
    case access_DENIED_JUDGE_ENTRY = 15
    case object_DELETED = 16
    case already_DELETED = 17
    case access_DENIED_REPO_ENTRY = 18
    
    
    // Client Errors
    case could_NOT_FIND_URL_404
    case internal_SERVER_ERROR_500
    case no_RESPONSE_FROM_SERVER_503
    case json_DID_NOT_PARSE
    case json_SERIALIZATION_FAILED
    
    func getDisplayDescription() -> String {
        switch self {
        case .login_INVALID_EMAIL:
            return "The email you entered could not be found. Please try a new one."
        case .login_WRONG_PASSWORD:
            return "The password that you entered was not correct. Please try again."
        case .sign_UP_INVALID_EMAIL:
            return "The email you entered is not a valid email address. Please try again."
        case .sign_UP_USERNAME_EXISTS:
            return "The username that you entered has already been taken. Please try a different one."
        case .sign_UP_EMAIL_EXISTS:
            return "The email that you entered has already been used. Please try a different one."
        default:
            return "An error occurred ☹️. Please try again later and make sure that you have updated the app."
        }
    }
    
    func getDebugDiscription() -> String {
        switch self {
        case .unknown_ERROR:
            return "UNKNOWN_ERROR: There was some unknown error."
        //Server Errors
        case .token_NOT_PROVIDED:
            return "TOKEN_NOT_PROVIDED: A token was not provided with the request."
        case .token_AUTH_FAILED:
            return "TOKEN_AUTH_FAILED: The token is either invalid or has expired."
        case .info_WRONG:
            return "INFO_WRONG: The info that went along with this request is not complete or not valid."
        case .repeat_VOTE:
            return "REPEAT_VOTE: There was a repeat vote."
        case .login_INVALID_EMAIL:
            return "LOGIN_INVALID_EMAIL: The email used to login was not found."
        case .login_WRONG_PASSWORD:
            return "LOGIN_WRONG_PASSWORD: The wrong password was used to login."
        case .sign_UP_INVALID_EMAIL:
            return "SIGN_UP_INVALID_EMAIL: The email entered was not valid."
        case .sign_UP_USERNAME_EXISTS:
            return "SIGN_UP_USERNAME_EXISTS: The username is taken."
        case .sign_UP_EMAIL_EXISTS:
            return "SIGN_UP_EMAIL_EXISTS: The email is taken."
        case .user_NOT_FOUND:
            return "USER_NOT_FOUND: The user was not found."
        case .repo_ENTRY_NOT_FOUND:
            return "REPO_ENTRY_NOT_FOUND: The repo entry was not found."
        case .cannot_VOTE_ON_OWN_OBJECT:
            return "CANNOT_VOTE_ON_OWN_OBJECT: Cannot vote on an object that the user did not create."
        case .repo_ENTRY_COMMENT_NOT_FOUND:
            return "REPO_ENTRY_COMMENT_NOT_FOUND: This comment was not found."
        case .judge_ENTRY_NOT_FOUND:
            return "JUDGE_ENTRY_NOT_FOUND: The judge entry was not found."
        case .access_DENIED_JUDGE_ENTRY:
            return "ACCESS_DENIED_JUDGE_ENTRY: The user does not have access to perform this operation."
        case .object_DELETED:
            return "OBJECT_DELETED: The object was deleted an therefore this operation cannot be performed."
        case .already_DELETED:
            return "ALREADY_DELETED: The object was already deleted. Another delete will fail."
        case .access_DENIED_REPO_ENTRY:
            return "ACCESS_DENIED_REPO_ENTRY: The user does not have access to perform this opertion on a repo entry."
        //Client Errors
        case .could_NOT_FIND_URL_404:
            return "COULD_NOT_FIND_URL_404: The url used was invalid."
        case .internal_SERVER_ERROR_500:
            return "INTERNAL_SERVER_ERROR_500: The server made a mistake."
        case .no_RESPONSE_FROM_SERVER_503:
            return "NO_RESPONSE_FROM_SERVER_503: Something else bad happened with the server."
        case .json_DID_NOT_PARSE:
            return "JSON_DID_NOT_PARSE: There was a problem parsing the JSON."
        case .json_SERIALIZATION_FAILED:
            return "JSON_SERIALIZATION_FAILED: There was a problem serializing the JSON."
        }
    }
    
    static func parseCode(_ code: Int)->Error {
        return Error.init(rawValue: code) ?? .unknown_ERROR
    }
    
    static func parseErrorFromResponse(_ response: URLResponse?)->Error? {
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 404: return .could_NOT_FIND_URL_404
            case 500: return .internal_SERVER_ERROR_500
            case 503: return .no_RESPONSE_FROM_SERVER_503
            default: return nil
            }
        } else {
            return Error.unknown_ERROR
        }
    }
    
    static func parseNSError(_ error: NSError)->Error {
        return Error.init(rawValue: error.code) ?? .unknown_ERROR
    }
    
}
