//
//  Extensions.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

extension NSWorkspace {
    
    public func isApplicationRunning(bundleIdentifier: String) -> Bool {
        return runningApplications.filter({ app in app.bundleIdentifier == bundleIdentifier }).count > 0
    }
    
}
