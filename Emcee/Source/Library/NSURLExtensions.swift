//
//  NSURLExtensions.swift
//  Emcee
//
//  Created by Simon Støvring on 29/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

extension NSURL {
    
    internal var queryParameters: [String: String]? {
        if let parameters = query?.componentsSeparatedByString("&") {
            if parameters.count == 0 {
                return nil
            }
            
            var queryParams = [String: String]()
            for param in parameters {
                let pair = param.componentsSeparatedByString("=")
                if pair.count == 2 {
                    queryParams[pair.first!] = pair.last!
                }
            }
            
            return queryParams
        }
        
        return nil
    }
    
}