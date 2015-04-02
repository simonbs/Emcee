//
//  OverviewViewController.swift
//  Emcee
//
//  Created by Simon Støvring on 02/04/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import AppKit

class OverviewViewController: NSViewController, TopViewControllerDelegate {
   
    @IBOutlet weak var loadingIndicatorView: NSProgressIndicator!
    
    private let topSegueIdentifier = "Top"
    private var hasRefreshedTop = false
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == topSegueIdentifier {
            if let controller = segue.destinationController as? TopViewController {
                controller.delegate = self
            }
        }
    }
    
    func topViewControllerDidStartRefresh(controller: TopViewController) {
        if !hasRefreshedTop {
            loadingIndicatorView.startAnimation(nil)
        }
    }
    
    func topViewControllerDidFinishRefreshing(controller: TopViewController) {
        loadingIndicatorView.stopAnimation(nil)
        hasRefreshedTop = true
    }
    
}
