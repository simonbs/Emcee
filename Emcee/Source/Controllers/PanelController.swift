//
//  PanelController.swift
//  Emcee
//
//  Created by Simon Støvring on 27/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import AppKit

protocol PanelControllerDelegate {
    func viewForStatusItemOpeningPanelController(panelController: PanelController) -> NSView
}

class PanelController: NSWindowController, NSWindowDelegate {
    
    internal var showAnimationDuration: NSTimeInterval = 0.15
    internal var closeAnimationDuration: NSTimeInterval = 0.15
    internal var delegate: PanelControllerDelegate?
    internal private(set) var visible: Bool = false
    private var backgroundView = PanelBackgroundView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let contentView = window?.contentView as NSView
        backgroundView.frame = contentView.bounds
        contentView.addSubview(backgroundView, positioned: .Below, relativeTo: nil)
        
        window?.acceptsMouseMovedEvents = true
        window?.level = kCGPopUpMenuWindowLevelKey
        window?.opaque = false
        window?.backgroundColor = .clearColor()
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
        
        if let statusItemView = delegate?.viewForStatusItemOpeningPanelController(self) {
            let statusItemFrame = statusItemFrameForStatusItemView(statusItemView)
            let panelRect = panelFrameWithStatusItemView(statusItemView)
            backgroundView.arrowX = statusItemFrame.midX - panelRect.minX
            
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
    
    private func statusItemFrameForStatusItemView(statusItemView: NSView) -> NSRect {
        return statusItemView.window!.convertRectToScreen(statusItemView.frame)
    }
    
    private func panelFrameWithStatusItemView(statusItemView: NSView) -> NSRect {
        let statusItemFrame = statusItemFrameForStatusItemView(statusItemView)
        let panelXPos = statusItemFrame.maxX - statusItemView.frame.width / 2 - window!.frame.width / 2
        let panelOrigin = NSPoint(x: panelXPos, y: statusItemFrame.maxY - window!.frame.height)
        return NSRect(origin: panelOrigin, size: window!.frame.size).integerRect
    }
    
    func windowDidResignKey(notification: NSNotification) {
        if window!.visible {
            hidePanel(animated: true)
        }
    }
    
    func windowDidResize(notification: NSNotification) {
        if let statusItemView = delegate?.viewForStatusItemOpeningPanelController(self) {
            let statusItemFrame = statusItemFrameForStatusItemView(statusItemView)
            let panelRect = panelFrameWithStatusItemView(statusItemView)
            backgroundView.arrowX = statusItemFrame.midX - panelRect.minX
        }
    }
    
}
