//
//  TopLevelFunctions.swift
//  Emcee
//
//  Created by Simon Støvring on 27/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import LastFMKit

func delay(delay: NSTimeInterval, closure: () -> ()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
}

func getAppDelegate() -> AppDelegate {
    return NSApplication.sharedApplication().delegate as! AppDelegate
}

func getStatusItemView() -> StatusItemView {
    return getAppDelegate().statusItemView
}