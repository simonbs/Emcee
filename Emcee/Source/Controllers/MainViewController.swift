//
//  MainViewController.swift
//  Emcee
//
//  Created by Simon Støvring on 29/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    override func viewWillAppear() {
        super.viewWillAppear()
        
        repositionArrow()
    }
    
    private func repositionArrow() {
        let backgroundView = view as PanelBackgroundView
        let statusItemView = getStatusItemView()
        let statusItemFrame = statusItemView.window!.convertRectToScreen(statusItemView.frame)
        let windowFrame = view.window!.frame
        
        let distanceToStatusItem = statusItemFrame.minX - windowFrame.minX
        backgroundView.arrowX = distanceToStatusItem + statusItemFrame.width / 2 + backgroundView.arrowSize.width / 2
    }
    
}
