//
//  TopTableRowView.swift
//  Emcee
//
//  Created by Simon Støvring on 31/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import Alamofire

class TopTableRowView: NSTableRowView {

    @IBOutlet weak var imageView: AspectFillImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var detailLabel: NSTextField!
    
    private var imageRequest: Alamofire.Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawBackgroundInRect(dirtyRect: NSRect) {
        NSRectFillUsingOperation(dirtyRect, .CompositeClear)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        imageRequest?.cancel()
        imageRequest = nil
    }
    
    internal func setImageWithURL(url: NSURL) {
        let imageReqest = NSURLRequest(URL: url)
        imageRequest = request(imageReqest).response { request, response, data, error in
            if let data = data as? NSData {
                if let image = NSImage(data: data) {
                    self.imageView.image = image
                }
            }
        }
    }
    
}
