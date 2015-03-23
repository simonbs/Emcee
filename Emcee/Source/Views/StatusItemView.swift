//
//  StatusItemView.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 22/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

@objc protocol StatusItemViewDelegate {
    optional func statusItemViewClicked(view: StatusItemView)
    optional func statusItemViewRightClicked(view: StatusItemView)
}

class StatusItemView: NSView {
    
    enum Style: String {
        case Dark = "dark"
        case Light = "light"
    }
    
    internal let item: NSStatusItem
    internal weak var delegate: StatusItemViewDelegate?
    internal var style: Style = .Dark {
        didSet { needsDisplay = true }
    }
    internal var text: String? {
        didSet { needsDisplay = true }
    }
    internal var isSelected: Bool = false {
        didSet {
            if (isSelected != oldValue) {
                self.needsDisplay = true
            }
        }
    }
    
    init(item: NSStatusItem) {
        self.item = item
        
        let thickness = NSStatusBar.systemStatusBar().thickness
        let rect = CGRectMake(0, 0, thickness, thickness)
        
        super.init(frame: rect)
        
        item.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        item.drawStatusBarBackgroundInRect(dirtyRect, withHighlight: isSelected)
        
        let thickness = NSStatusBar.systemStatusBar().thickness
        
        if let text = text {
            var attributes: [String: AnyObject] = [ NSFontNameAttribute: NSFont.systemFontOfSize(20) ]
            if style == .Light {
                attributes[NSForegroundColorAttributeName] = NSColor.whiteColor()
            } else {
                attributes[NSForegroundColorAttributeName] = NSColor.blackColor()
            }
            
            let str = text as NSString
            let maxSize = NSSize(width: CGFloat(MAXFLOAT), height: thickness)
            let textSize = str.boundingRectWithSize(maxSize, options: nil, attributes: attributes)
            let yOffset = (thickness - textSize.height) / 2
            let rect = NSRect(x: 0, y: yOffset, width: textSize.width, height: textSize.height)
            str.drawInRect(rect, withAttributes: attributes)
            item.length = rect.width
        } else {
            let image = NSImage(named: "statusbar-\(style.rawValue)")!
            let yOffset = (thickness - image.size.height) / 2
            let rect = CGRectMake(0, yOffset, image.size.width, image.size.height)
            image.drawInRect(rect)
            item.length = image.size.width
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        delegate?.statusItemViewClicked?(self)
    }
    
    override func rightMouseDown(theEvent: NSEvent) {
        delegate?.statusItemViewRightClicked?(self)
    }
    
}
