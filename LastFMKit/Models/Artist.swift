//
//  Artist.swift
//  Emcee
//
//  Created by Simon Støvring on 31/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Artist {

    public let name: String
    public let playcount: Int
    public let url: NSURL
    public let images: [Asset]
    
    init(json: JSON) {
        name = json["name"].stringValue
        playcount = json["playcount"].intValue
        url = json["url"].URL!
        
        var mutableAssets = [Asset]()
        for imageJson in json["image"].arrayValue {
            mutableAssets.append(Asset(json: imageJson))
        }
        
        images = mutableAssets
    }
    
    public func smallestImage() -> Asset? {
        return images.sort { $0.rank < $1.rank }.first
    }
    
    public func largestImage() -> Asset? {
        return images.sort { $0.rank > $1.rank }.first
    }
   
}
