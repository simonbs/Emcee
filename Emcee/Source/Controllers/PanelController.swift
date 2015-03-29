//
//  PanelController.swift
//  Emcee
//
//  Created by Simon Støvring on 27/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import AppKit

class PanelController: NSWindowController, NSWindowDelegate {
    
    internal var showAnimationDuration: NSTimeInterval = 0.15
    internal var closeAnimationDuration: NSTimeInterval = 0.15
    internal private(set) var visible: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        window?.acceptsMouseMovedEvents = true
        window?.level = kCGPopUpMenuWindowLevelKey
        window?.opaque = false
    }
    
    // MARK: - Private methods
    
    internal func toggleVisibility(animated: Bool = false) {
        if visible {
            hidePanel(animated: animated)
        } else {
            showPanel(animated: animated)
        }
    }
    
    internal func showPanel(animated: Bool = false) {
        if visible {
            return
        }
        
        let statusItemView = getStatusItemView()
        let statusItemFrame = statusItemView.window!.convertRectToScreen(statusItemView.frame)
        let screen = NSScreen.screens()!.first as NSScreen
        
        let panelXPos = statusItemFrame.maxX - statusItemView.frame.width / 2 - window!.frame.width / 2
        let panelOrigin = NSPoint(x: panelXPos, y: statusItemFrame.maxY - window!.frame.height)
        var panelRect = NSRect(origin: panelOrigin, size: window!.frame.size).integerRect
        if panelRect.maxX > screen.frame.maxX {
            panelRect.origin.x = screen.frame.maxX - window!.frame.width
        }
        
        NSApp.activateIgnoringOtherApps(false)
        window?.alphaValue = animated ? 0 : 1
        window?.setFrame(panelRect, display: true)
        window?.makeKeyAndOrderFront(nil)
        
        if animated {
            NSAnimationContext.beginGrouping()
            NSAnimationContext.currentContext().duration = showAnimationDuration
            window?.animator().alphaValue = 1
            NSAnimationContext.endGrouping()
        }
        
        visible = true
    }
    
    internal func hidePanel(animated: Bool = false) {
        if !visible {
            return
        }
        
        if animated {
            NSAnimationContext.beginGrouping()
            NSAnimationContext.currentContext().duration = closeAnimationDuration
            window?.animator().alphaValue = 0
            NSAnimationContext.endGrouping()
            
            delay(0.40) {
                self.window?.orderOut(nil)
                return
            }
        } else {
            window?.alphaValue = 0
            window?.orderOut(nil)
        }
        
        visible = false
    }
    
    func windowDidResignKey(notification: NSNotification) {
        if window!.visible {
            hidePanel(animated: true)
        }
    }
    
}
