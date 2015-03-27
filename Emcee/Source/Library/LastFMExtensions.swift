//
//  LastFMExtensions.swift
//  Emcee
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import LastFMKit

extension LastFMKit.Client {
    
    internal func authorize(completion: ((Bool, NSError?) -> ())? = nil) {
        getToken { (token, redirectURL, error) in
            if let error = error {
                completion?(false, error)
                return
            }
            
            if let token = token {
                if let redirectURL = redirectURL {
                    NSWorkspace.sharedWorkspace().openURL(redirectURL)
                } else {
                    completion?(false, nil)
                }
            } else {
                completion?(false, nil)
            }
        }
    }
    
}
