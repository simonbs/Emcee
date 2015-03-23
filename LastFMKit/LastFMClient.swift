//
//  LastFMClient.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

public class LastFMClient {
   
    private let apiKey: String
    private let secret: String
    
    public init(apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secret = secret
        // http://ws.audioscrobbler.com/2.0/
    }
    
    public func authorize() {
        getToken()
    }
    
    public func getToken() {
        let params = parameters("auth.gettoken")
        Alamofire.request(.GET, "http://ws.audioscrobbler.com/2.0/", parameters: params, encoding: .URL)
            .responseJSON { (request, response, jsonResponse, error) in
                if let error = error {
                    NSLog("\(error)")
                }
                
                if let jsonResponse: AnyObject = jsonResponse {
                    NSLog("\(jsonResponse)")
                }
        }
    }
    
    private func parameters(method: String, _ params: [String: AnyObject] = [:]) -> [String: AnyObject] {
        var allParams = params
        allParams["method"] = method
        allParams["format"] = "json"
        allParams["api_key"] = apiKey
        allParams["api_sig"] = signature(allParams)
        return allParams
    }
    
    private func signature(_ params: [String: AnyObject] = [:]) -> String {
        let sortedParams = sorted(params) { $0.0 < $1.0 }
        var str = ""
        for (key, value) in sortedParams {
            if let strValue = value as? String {
                str = str + key + strValue
            }
        }
        
        str = str + secret
        return str.md5()!
    }
    
}
