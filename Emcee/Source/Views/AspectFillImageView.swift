//
//  AspectFillImageView.swift
//  Emcee
//
//  Created by Simon Støvring on 02/04/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import AppKit

class AspectFillImageView: NSView {
    
    internal var image: NSImage? {
        didSet { needsDisplay = true }
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextClearRect(context, dirtyRect)
        if let image = image {
            let targetSize = bounds.size
            let widthFactor = targetSize.width / image.size.width
            let heightFactor = targetSize.height / image.size.height
            let scaleFactor = max(widthFactor, heightFactor)
            let scaledSize = image.size * scaleFactor
            let pos = CGPointMake((targetSize.width - scaledSize.width) / 2, (targetSize.height - scaledSize.height) / 2)
            let newRect = CGRectMake(pos.x, pos.y, scaledSize.width, scaledSize.height).integerRect
            image.drawInRect(newRect)
        }
    }
   
}
