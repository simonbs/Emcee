//
//  Operators.swift
//  Emcee
//
//  Created by Simon Støvring on 02/04/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

func *(left: CGSize, right: CGFloat) -> CGSize {
    return left.scale(right)
}

func /(left: CGSize, right: CGFloat) -> CGSize {
    return left.scale(1 / right)
}
