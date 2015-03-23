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
    func artworks() -> NSArray
}

@objc protocol iTunesArtwork {
    optional var data: NSImage { get set }
    optional var objectDescription: String { get set }
    optional var downloaded: Bool { get }
    optional var format: NSNumber { get }
    optional var kind: Int { get set }
    optional var rawData: NSData { get set }
}

@objc protocol iTunesApplication {
    optional var currentTrack: iTunesTrack { get }
    optional var playerState: iTunesEPlS { get }
}

extension SBApplication: iTunesApplication {}
