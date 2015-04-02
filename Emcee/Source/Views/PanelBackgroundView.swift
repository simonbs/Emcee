//
//  PanelBackgroundView.swift
//  Emcee
//
//  Created by Simon Støvring on 27/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

@IBDesignable
class PanelBackgroundView: NSView {
    
    @IBInspectable internal var lineThickness: CGFloat = 1 {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable internal var arrowSize: CGSize = CGSizeMake(18, 10) {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable internal var cornerRadius: CGFloat = 5 {
        didSet { needsDisplay = true }
    }
    
    internal var arrowX: CGFloat = 0 {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable internal var fillColor: NSColor = NSColor(deviceWhite: 1, alpha: 0.98) {
        didSet { needsDisplay = true }
    }
    
    @IBInspectable internal var strokeColor: NSColor = .whiteColor() {
        didSet { needsDisplay = true }
    }
    
    override func prepareForInterfaceBuilder() {
        arrowX = bounds.width / 2
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
        
        fillColor.setFill()
        path.fill()
        
        NSGraphicsContext.saveGraphicsState()
        
        let clip = NSBezierPath(rect: bounds)
        clip.appendBezierPath(path)
        clip.addClip()

        path.lineWidth = lineThickness * 2
        strokeColor.setStroke()
        path.stroke()
        
        NSGraphicsContext.restoreGraphicsState()
    }
    
}
