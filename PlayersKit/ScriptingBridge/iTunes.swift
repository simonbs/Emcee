//
//  iTunes.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import ScriptingBridge

@objc protocol iTunesItem {
    optional var name: String { get }
}

@objc protocol iTunesTrack: iTunesItem {
    optional var album: String { get }
    optional var albumArtist: String { get }
    optional var artist: String { get }
    optional var podcast: Bool { get }
    func artworks() -> SBElementArray
}

@objc protocol iTunesArtwork: iTunesItem {
    optional var data: NSImage { get }
    optional var format: NSNumber { get }
}

@objc protocol iTunesApplication {
    optional var currentTrack: iTunesTrack { get }
    optional var playerState: iTunesEPlS { get }
}

extension SBApplication: iTunesApplication {}
