//
//  NetworkClient.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class NetworkClient {
    
    public typealias RequestCompletion = ((JSON?, NSError?) -> ())
    
    public var cachePolicy: NSURLRequestCachePolicy = .ReloadIgnoringLocalCacheData
    public var timeoutInterval: NSTimeInterval = 30
    
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    public func get(url: NSURL, completion: RequestCompletion? = nil) -> NSURLSessionDataTask {
        let request = createRequest(url)
        request.HTTPMethod = "GET"
        return performRequest(request, completion: completion)
    }
    
    public func performRequest(request: NSURLRequest, completion: RequestCompletion? = nil) -> NSURLSessionDataTask {
        let task = session.dataTaskWithRequest(request) { [weak self] data, response, error in
            if let error = error {
                completion?(nil, error)
                return
            }
            
            if let data = data {
                var jsonError: NSError?
                let json = JSON(data: data, options: NSJSONReadingOptions(0), error: &jsonError)
                if let error = json.error {
                    completion?(nil, error)
                    return
                }
                
                completion?(json, jsonError)
            }
        }
        
        task.resume()
        return task
    }
    
    private func createRequest(url: NSURL) -> NSMutableURLRequest {
        return NSMutableURLRequest(URL: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }
   
}
