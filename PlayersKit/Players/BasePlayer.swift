//
//  BasePlayer.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

public class BasePlayer: NSObject, Player {
    
    public class var bundleIdentifier: String { return "" }
    public var playerBundleIdentifier: String { return BasePlayer.bundleIdentifier }
    public var delegate: PlayerDelegate?
    public private(set) var isStarted: Bool = false
    public internal(set) var currentTrack: Track? {
        didSet {
            if let currentTrack = currentTrack {
                if currentTrack != oldValue {
                    delegate?.playerDidChangeTrack(self, track: currentTrack)
                }
            }
        }
    }
    public internal(set) var playbackState: PlaybackState = .Stopped {
        didSet {
            if playbackState != oldValue {
                if playbackState == .Playing {
                    delegate?.playerDidPlay(self)
                } else if playbackState == .Paused {
                    delegate?.playerDidPause(self)
                } else if playbackState == .Stopped {
                    delegate?.playerDidStop(self)
                }
            }
        }
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        if !isStarted {
            isStarted = true
        }
    }
    
    public func stop() {
        if isStarted {
            isStarted = false
        }
    }
    
}
