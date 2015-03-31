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
    private let lastFMUsernameKey = "dk.simonbs.Emcee.LastFMUsername"
    private let lastFMAuthenticationKeyKey = "dk.simonbs.Emcee.lastFMAuthenticationKey"
    
    internal var lastFMUsername: String? {
        set { store.setObject(newValue, forKey: lastFMUsernameKey ) }
        get { return store.stringForKey(lastFMUsernameKey) }
    }
    
    internal var lastFMAuthenticationKey: String? {
        set { store.setObject(newValue, forKey: lastFMAuthenticationKeyKey ) }
        get { return store.stringForKey(lastFMAuthenticationKeyKey) }
    }
    
    init(store: NSUserDefaults = .standardUserDefaults()) {
        self.store = store
    }
    
}
