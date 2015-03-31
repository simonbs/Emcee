//
//  Asset.swift
//  Emcee
//
//  Created by Simon Støvring on 31/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Asset {
    
    public enum Size: String {
        case Small = "small"
        case Medium = "medium"
        case Large = "large"
        case ExtraLarge = "extralarge"
        case Mega = "mega"
    }
    
    public let size: Size
    public let url: NSURL
    public var rank: Int {
        switch size {
        case .Small:
            return 0
        case .Medium:
            return 1
        case .Large:
            return 2
        case .ExtraLarge:
            return 3
        case .Mega:
            return 4
        }
    }
    
    init(json: JSON) {
        size = Size(rawValue: json["size"].stringValue)!
        url = json["#text"].URL!
    }
    
}