//
//  Rdio.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import ScriptingBridge

@objc protocol RdioTrack {
    optional var artist: String { get }
    optional var album: String { get }
    optional var duration: Int { get }
    optional var name: String { get }
    optional var artwork: NSData { get }
    optional var rdioUrl: String { get }
    optional var key: String { get }
}

@objc protocol RdioApplication {
    optional var currentTrack: RdioTrack { get }
    optional var soundVolume: Int { get set }
    optional var playerState: RdioEPSS { get }
    optional var playerPosition: Int { get set }
    optional var shuffle: Bool { get set }
    optional var repeatState: RdioERep { get set }
    optional func addToCollection()
    optional func removeFromCollection()
    optional func syncToMobile()
    optional func removeFromMobile()
    optional func nextTrack()
    optional func previousTrack()
    optional func playpause()
    optional func pause()
    optional func playSource(source: String)
}

extension SBApplication: RdioApplication { }
