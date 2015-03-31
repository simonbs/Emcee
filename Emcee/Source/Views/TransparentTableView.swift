//
//  TransparentTableView.swift
//  Emcee
//
//  Created by Simon Støvring on 31/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import AppKit

class TransparentTableView: NSTableView {
    
    override var opaque: Bool {
        return false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enclosingScrollView?.drawsBackground = false
    }
    
    override func drawBackgroundInClipRect(clipRect: NSRect) {
        NSRectFillUsingOperation(clipRect, .CompositeClear)
    }
   
}
