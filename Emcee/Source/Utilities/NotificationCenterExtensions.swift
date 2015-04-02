//
//  NotificationCenterExtensions.swift
//  Emcee
//
//  Created by Simon Støvring on 31/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

extension NSNotificationCenter {
    
    public func addObserver(observer: AnyObject, selector: Selector, name: String) {
        addObserver(observer, selector: selector, name: name, object: nil)
    }
    
    public func postNotificationName(name: String) {
        postNotificationName(name, object: nil)
    }
    
}