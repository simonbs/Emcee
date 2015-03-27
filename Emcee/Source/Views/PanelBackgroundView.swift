//
//  PanelBackgroundView.swift
//  Emcee
//
//  Created by Simon Støvring on 27/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

/*
#define FILL_OPACITY 0.9f
#define STROKE_OPACITY 1.0f

#define LINE_THICKNESS 1.0f
#define CORNER_RADIUS 6.0f

#define SEARCH_INSET 10.0f
*/

class PanelBackgroundView: NSView {
    
    private let lineThickness: CGFloat = 1
    private let arrowSize = CGSizeMake(12, 8)
    private let cornerRadius: CGFloat = 5
    
    internal var arrowX: CGFloat = 0 {
        didSet { needsDisplay = true }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let contentRect = NSInsetRect(bounds, lineThickness, lineThickness)
        let path = NSBezierPath()
        
        path.moveToPoint(NSMakePoint(arrowX, contentRect.maxY))
        path.lineToPoint(NSMakePoint(arrowX + arrowSize.width / 2, contentRect.maxY - arrowSize.height))
        path.lineToPoint(NSMakePoint(contentRect.maxX - cornerRadius, contentRect.maxY - arrowSize.height))
        
        let topRightCorner = NSMakePoint(contentRect.maxX, contentRect.maxY - arrowSize.height)
        path.curveToPoint(NSMakePoint(contentRect.maxX, contentRect.maxY - arrowSize.height - cornerRadius), controlPoint1: topRightCorner, controlPoint2: topRightCorner)
        
        path.lineToPoint(NSMakePoint(contentRect.maxX, contentRect.minY + cornerRadius))
        
        let bottomRightCorner = NSMakePoint(contentRect.maxX, contentRect.minY)
        path.curveToPoint(NSMakePoint(contentRect.maxX - cornerRadius, contentRect.minY), controlPoint1: bottomRightCorner, controlPoint2: bottomRightCorner)

        path.lineToPoint(NSMakePoint(contentRect.minX + cornerRadius, contentRect.minY))
        
        path.curveToPoint(NSMakePoint(contentRect.minX, contentRect.minY + cornerRadius), controlPoint1: contentRect.origin, controlPoint2: contentRect.origin)
        
        path.lineToPoint(NSMakePoint(contentRect.minX, contentRect.maxY - arrowSize.height - cornerRadius))
        
        let topLeftCorner = NSMakePoint(contentRect.minX, contentRect.maxY - arrowSize.height)
        path.curveToPoint(NSMakePoint(contentRect.minX + cornerRadius, contentRect.maxY - arrowSize.height), controlPoint1: topLeftCorner, controlPoint2: topLeftCorner)
        
        path.lineToPoint(NSMakePoint(arrowX - arrowSize.width / 2, contentRect.maxY - arrowSize.height))
        path.closePath()
        
        NSColor(deviceWhite: 1, alpha: 0.90).setFill()
        path.fill()
        
        NSGraphicsContext.saveGraphicsState()
        
        let clip = NSBezierPath(rect: bounds)
        clip.appendBezierPath(path)
        clip.addClip()
        
        path.lineWidth = lineThickness * 2
        NSColor.whiteColor().setStroke()
        path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
}

/*

[[NSColor colorWithDeviceWhite:1 alpha:FILL_OPACITY] setFill];
[path fill];

[NSGraphicsContext saveGraphicsState];

NSBezierPath *clip = [NSBezierPath bezierPathWithRect:[self bounds]];
[clip appendBezierPath:path];
[clip addClip];

[path setLineWidth:LINE_THICKNESS * 2];
[[NSColor whiteColor] setStroke];
[path stroke];

[NSGraphicsContext restoreGraphicsState];
*/