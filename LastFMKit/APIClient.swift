//
//  APIClient.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

public class APIClient: NetworkClient {
    
    private var baseURL: NSURL
    
    init(baseURL: NSURL) {
        self.baseURL = baseURL
    }
    
    public func get(path: String, completion: RequestCompletion?) -> NSURLSessionDataTask {
        return get(urlWithPath(path), completion: completion)
    }
    
    private func urlWithPath(path: String) -> NSURL {
        return baseURL.URLByAppendingPathComponent(path)
    }
   
}
