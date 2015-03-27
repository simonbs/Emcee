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

class PanelController: NSWindowController {
    
    internal var showAnimationDuration: NSTimeInterval = 0.15
    internal var closeAnimationDuration: NSTimeInterval = 0.15
    internal var delegate: PanelControllerDelegate?
    internal private(set) var visible: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        window?.acceptsMouseMovedEvents = true
        window?.level = kCGPopUpMenuWindowLevelKey
        window?.opaque = false
//        window?.backgroundColor = .clearColor()
        window?.setFrame(window!.frame, display: false)
    }
    
    // MARK: - Private methods
    
    internal func toggleVisibility(animated: Bool = false) {
        if visible {
            closePanel(animated: animated)
        } else {
            openPanel(animated: animated)
        }
    }
    
    internal func openPanel(animated: Bool = false) {
        if visible {
            return
        }
        
        let panel = window as NSPanel
        if let statusItemView = delegate?.viewForStatusItemOpeningPanelController(self) {
            let statusItemFrame = statusItemView.window!.convertRectToScreen(statusItemView.frame)
            let panelXPos = statusItemFrame.maxX - statusItemView.frame.width / 2 - panel.frame.width / 2
            let panelOrigin = NSPoint(x: panelXPos, y: statusItemFrame.maxY - panel.frame.height)
            let panelRect = NSRect(origin: panelOrigin, size: panel.frame.size).integerRect
        
            NSApplication.sharedApplication().activateIgnoringOtherApps(false)
            panel.alphaValue = animated ? 0 : 1
            panel.setFrame(panelRect, display: true)
            panel.makeKeyAndOrderFront(nil)
        }
    
        if animated {
            NSAnimationContext.beginGrouping()
            NSAnimationContext.currentContext().duration = showAnimationDuration
            panel.animator().alphaValue = 1
            NSAnimationContext.endGrouping()
        }
        
        visible = true
    }
    
    internal func closePanel(animated: Bool = false) {
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
    
    private func statusRect() -> NSRect? {
        let screenRect = NSScreen.screens()!.first!.frame
        let view = delegate?.viewForStatusItemOpeningPanelController(self)
        if let view = view {
            return view.window!.convertRectToScreen(view.frame)
        }
        
        return nil
    }
    
}
