//
//  Preferences.swift
//  Emcee
//
//  Created by Simon Støvring on 29/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

class Preferences {

    private var store: NSUserDefaults
    private let lastFMTokenKey = "dk.simonbs.Emcee.LastFMToken"
    
    internal var lastFMToken: String? {
        set { store.setObject(newValue, forKey: lastFMTokenKey) }
        get { return store.stringForKey(lastFMTokenKey) }
    }
    
    init(store: NSUserDefaults = .standardUserDefaults()) {
        self.store = store
    }
    
}
