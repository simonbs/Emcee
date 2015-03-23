//
//  iTunesPlayer.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import ScriptingBridge

public class iTunesPlayer: BasePlayer {
    
    override public class var bundleIdentifier: String { return "com.apple.iTunes" }
    override public var playerBundleIdentifier: String { return iTunesPlayer.bundleIdentifier }
    
    private let playbackStateChangedNotification = "com.apple.iTunes.playerInfo"
    private let iTunes: iTunesApplication = SBApplication(bundleIdentifier: iTunesPlayer.bundleIdentifier)

    override public func start() {
        if !isStarted {
            let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
            notificationCenter.addObserver(self, selector: Selector("playbackStateChanged:"), name: playbackStateChangedNotification, object: nil)
            updateCurrentTrack()
        }
        
        super.start()
    }
    
    override public func stop() {
        if isStarted {
            let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
            notificationCenter.removeObserver(self)
        }
        
        super.stop()
    }
    
    func playbackStateChanged(notification: NSNotification) {
        updateCurrentTrack()
    }
    
    private func updateCurrentTrack() {
        if (iTunes as SBApplication).running {
            if let playerState = iTunes.playerState {
                switch playerState.value {
                case iTunesEPlSPaused.value:
                    playbackState = .Paused
                case iTunesEPlSStopped.value:
                    playbackState = .Stopped
                    currentTrack = nil
                case iTunesEPlSFastForwarding.value:
                    fallthrough
                case iTunesEPlSRewinding.value:
                    fallthrough
                case iTunesEPlSPlaying.value:
                    playbackState = .Playing
                    if let track = iTunes.currentTrack {
                        currentTrack = Track(artistName: track.artist!, trackName: track.name!)
                    }
                default:
                    break
                }
            }
        }
    }
    
}
