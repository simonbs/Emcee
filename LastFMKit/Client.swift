//
//  Client.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
import SwiftyJSON

public class Client {
    
    public let apiKey: String
    private let secret: String
    private let baseURL = "http://ws.audioscrobbler.com/2.0/"
    
    public init(apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secret = secret
    }
    
    public func getToken(completion: (String?, NSURL?, NSError?) -> ()) -> Alamofire.Request {
        return performRequest(method: Endpoint.Auth.GetToken.rawValue, completion: { json, error in
            if let error = error {
                completion(nil, nil, error)
            } else if let token = json?["token"].string {
                let redirectURL = "http://www.last.fm/api/auth/?api_key=" + self.apiKey + "&token=" + token
                completion(token, NSURL(string: redirectURL), nil)
            } else {
                completion(nil, nil, nil)
            }
        })
    }
    
    public func getSession(token: String, completion: (Session?, NSError?) -> ()) -> Alamofire.Request {
        let params = [ "token": token ]
        return performRequest(method: Endpoint.Auth.GetSession.rawValue, params: params) { json, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(Session(json: json!), nil)
            }
        }
    }
    
    public func getTopArtists(username: String, period: Period = .Overall, limit: Int = 50, page: Int = 0, completion: ([Artist]?, NSError?) -> ()) -> Alamofire.Request {
        let params: [String: AnyObject] = [
            "user": username,
            "period": period.rawValue,
            "limit": limit,
            "page": page
        ]
        return performRequest(method: Endpoint.User.GetTopArtists.rawValue, params: params) { json, error in
            if let error = error {
                completion(nil, error)
            } else {
                if let jsonArtists = json!["topartists"]["artist"].array {
                    let artists = jsonArtists.map({ jsonArtist in Artist(json: jsonArtist) })
                    completion(artists, nil)
                } else {
                    completion([], nil)
                }
            }
        }
    }
    
    internal func performRequest(httpMethod: Alamofire.Method = .GET, method: String, params: [String: AnyObject] = [:], completion: (JSON?, NSError?) -> ()) -> Alamofire.Request {
        let allParams = parameters(method, params)
        return request(httpMethod, baseURL, parameters: allParams, encoding: .URL).responseJSON { response in
            if let error = response.result.error {
                return completion(nil, error)
            }
            
            if let jsonResponse = response.result.value as? [String: AnyObject] {
                if let lastFMError = Error.createError(jsonResponse) {
                    return completion(nil, lastFMError)
                }
                
                let json = JSON(jsonResponse)
                return completion(json, json.error)
            }
            
            completion(nil, nil)
        }
    }
    
    private func parameters(method: String, _ params: [String: AnyObject] = [:]) -> [String: AnyObject] {
        var allParams = params
        allParams["method"] = method
        allParams["api_key"] = apiKey
        allParams["api_sig"] = signature(allParams)
        allParams["format"] = "json"
        return allParams
    }
    
    private func signature(params: [String: AnyObject] = [:]) -> String {
        let sortedParams = params.sort { $0.0 < $1.0 }
        var str = ""
        for (key, value) in sortedParams {
            if let strValue = value as? String {
                str = str + key + strValue
            }
        }
        
        str = str + secret
        return str.md5()
    }
    
}
