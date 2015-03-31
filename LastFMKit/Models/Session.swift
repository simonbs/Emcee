//
//  Session.swift
//  Emcee
//
//  Created by Simon Støvring on 31/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Session {
    
    public let username: String
    public let key: String
    public let subscriber: Bool
    
    init(json: JSON) {
        let session = json["session"].dictionaryValue
        username = session["name"]!.stringValue
        key = session["key"]!.stringValue
        subscriber = session["subscriber"]!.boolValue
    }
   
}
