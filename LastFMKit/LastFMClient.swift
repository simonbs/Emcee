//
//  LastFMClient.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

public class LastFMClient: APIClient {
   
    private let apiKey: String
    private let secret: String
    
    public init(apiKey: String, secret: String) {
        self.apiKey = apiKey
        self.secret = secret
        super.init(baseURL: NSURL(string: "http://ws.audioscrobbler.com/2.0/")!)
    }
    
    public func getToken() {
        
    }
    
}
