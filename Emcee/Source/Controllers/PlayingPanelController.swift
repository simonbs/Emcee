//
//  PlayingPanelController.swift
//  Emcee
//
//  Created by Simon Støvring on 27/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

class PlayingPanelController: PanelController {

    @IBOutlet weak var connectButton: NSButton!
    
    @IBAction func connectPressed(sender: AnyObject) {
        let apiKey = getLastFMClient().apiKey
        let callback = "emcee://auth/callback"
        if let url = NSURL(string: "http://www.last.fm/api/auth/?api_key=" + apiKey + "&cb=" + callback) {
            NSWorkspace.sharedWorkspace().openURL(url)
        }
    }
}
