//
//  MainViewController.swift
//  Emcee
//
//  Created by Simon Støvring on 29/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    private var currentController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didConnectToLastFM:"), name: DidConnectToLastFMNotification, object: nil)
                
        if let lastFMToken = Preferences().lastFMToken {
            showControllerWithIdentifier("Overview")
        } else {
            showControllerWithIdentifier("Connect")
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        
        repositionArrow()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func repositionArrow() {
        let backgroundView = view as PanelBackgroundView
        let statusItemView = getStatusItemView()
        let statusItemFrame = statusItemView.window!.convertRectToScreen(statusItemView.frame)
        let windowFrame = view.window!.frame
        
        let distanceToStatusItem = statusItemFrame.minX - windowFrame.minX
        backgroundView.arrowX = distanceToStatusItem + statusItemFrame.width / 2
    }
    
    private func showControllerWithIdentifier(identifier: String) {
        if let currentController = currentController {
            currentController.view.removeFromSuperview()
            currentController.removeFromParentViewController()
            self.currentController = nil
        }
        
        if let newController = storyboard?.instantiateControllerWithIdentifier(identifier) as? NSViewController {
            addChildViewController(newController)
            view.addSubview(newController.view)
            view.constraints(vertical: "|[newView]|", horizontal: "|[newView]|", [ "newView" : newController.view ])
            currentController = newController
        }
    }
    
    func didConnectToLastFM(notification: NSNotification) {
        showControllerWithIdentifier("Overview")
    }
}
