//
//  RequestManager.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/24/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

class RequestManager {
    
    static let singleton = RequestManager()
    
    fileprivate var foundToken: String? = nil
    fileprivate var triedInternalDataStoreForToken = false

    var token: String? {
        get {
            return foundToken ?? getTokenFromDataStore()
        } set (tokenFound) {
            Foundation.UserDefaults.standard.set(tokenFound!, forKey: UserDefaults.TOKEN)
            foundToken = tokenFound
        }
    }

    var currentUser: User? = nil
    
    func getTokenFromDataStore()->String? {
        guard !triedInternalDataStoreForToken else { return nil }
        foundToken = Foundation.UserDefaults.standard.object(forKey: UserDefaults.TOKEN) as? String
        triedInternalDataStoreForToken = true
        return foundToken
    }

    func runPost(url: URLUsable, body: [String : String], vc: CrowdismaVC?, completion: @escaping ERROR_DATA_COMP) {
        let mutableRequest = url.getURLRequestWithMethod()
        let request = url.convertMutableURLRequest(mutableRequest: mutableRequest)
        if let serializationError = RequestManager.JSONForRequestBody(json: body as AnyObject, request: mutableRequest) {
            completion(serializationError, nil)
            return
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (responseData, response, serverError) -> Void in
            var err: Error? = nil
            if let data = RequestManager.parseJSONAndInspectForError(data: responseData, response: response, vc: vc, serverError: serverError as NSError?, error: &err) {
                completion(err, data)
            } else {
                completion(err ?? Error.unknown_ERROR, nil)
            }
        }) ; task.resume()
    }

    static func parseJSONAndInspectForError(data: Data?, response: URLResponse?, vc: CrowdismaVC?, serverError: NSError?, error err: inout Error?) -> AnyObject? {
        guard serverError == nil else {
            err = Error.parseNSError(serverError!)
            return nil
        }
        if let responseError = Error.parseErrorFromResponse(response) {
            err = responseError
            return nil
        }
        do {
            let parsedData = try JSONSerialization.jsonObject(with: data!, options: APIConstants.DEFAULT_JSON_READING)
            if let errorCode = ((parsedData as AnyObject).object(forKey: "errorCode") as? NSNumber)?.intValue {
                err = Error.parseCode(errorCode)
                if (err == .token_NOT_PROVIDED || err == .token_AUTH_FAILED) {
                    vc?.displayLoginSignUp()
                }
                return nil
            } else { return parsedData as AnyObject }
        } catch {
            err = .json_DID_NOT_PARSE
            return nil
        }
    }
        
    static func JSONForRequestBody(json: AnyObject, request: NSMutableURLRequest) -> Error? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpBody = jsonData
                return nil
        } catch {
                return .json_SERIALIZATION_FAILED
        }
    }
        
    fileprivate func _convertMutableUrl(mutableURL: NSMutableURLRequest)->NSURL? {
        return (mutableURL.copy() as? NSURL)
    }
        
}
