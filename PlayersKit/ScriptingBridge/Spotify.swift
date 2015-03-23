//
//  Spotify.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import ScriptingBridge

@objc protocol SpotifyTrack {
    optional var artist: String { get }
    optional var album: String { get }
    optional var discNumber: Int { get }
    optional var duration: Int { get }
    optional var playedCount: Int { get }
    optional var trackNumber: Int { get }
    optional var starred: Bool { get }
    optional var popularity: Int { get }
    optional var name: String { get }
    optional var artwork: NSImage { get }
    optional var albumArtist: String { get }
    optional var spotifyUrl: String { get }
    optional func id() -> String
}

@objc protocol SpotifyApplication {
    optional var currentTrack: SpotifyTrack { get }
    optional var soundVolume: Int { get set }
    optional var playerState: SpotifyEPlS { get }
    optional var playerPosition: Double { get set }
    optional var repeatingEnabled: Bool { get }
    optional var repeating: Bool { get set }
    optional var shufflingEnabled: Bool { get }
    optional var shuffling: Bool { get set }
    optional func nextTrack()
    optional func previousTrack()
    optional func playpause()
    optional func pause()
    optional func play()
    optional func playTrack(x: String, inContext: String)
}

extension SBApplication: SpotifyApplication {}

