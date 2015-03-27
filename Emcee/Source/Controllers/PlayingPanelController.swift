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
        getLastFMClient().authorize { success, error in
            if let error = error {
                NSLog("Could not authorize: \(error)")
            } else if !success {
                NSLog("Could not authorize but got no error")
            } else {
                NSLog("Successfully authorized!")
            }
        }
    }
}
