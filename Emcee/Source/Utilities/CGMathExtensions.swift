//
//  CGMathExtensions.swift
//  Emcee
//
//  Created by Simon Støvring on 02/04/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

extension CGSize {
    
    internal func scale(factor: CGFloat) -> CGSize {
        return CGSizeMake(width * factor, height * factor)
    }
    
}