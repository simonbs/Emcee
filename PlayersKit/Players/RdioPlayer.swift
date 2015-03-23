//
//  RdioPlayer.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import ScriptingBridge

public class RdioPlayer: BasePlayer {
    
    override public class var bundleIdentifier: String { return "com.rdio.desktop" }
    override public var playerBundleIdentifier: String { return RdioPlayer.bundleIdentifier }
    
    private let playbackStateChangedNotification = "com.rdio.desktop.playStateChanged"
    private let rdio: RdioApplication = SBApplication(bundleIdentifier: RdioPlayer.bundleIdentifier)
    
    override public func start() {
        if !isStarted {
            let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
            notificationCenter.addObserver(self, selector: "playbackStateChanged:", name: playbackStateChangedNotification, object: nil)
            updatePlaybackState()
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
        updatePlaybackState()
    }
    
    private func updatePlaybackState() {
        if (rdio as SBApplication).running {
            if let playerState = rdio.playerState {
                switch playerState.value {
                case RdioEPSSPlaying.value:
                    playbackState = .Playing
                    if let track = rdio.currentTrack {
                        currentTrack = Track(
                            artistName: track.artist!,
                            trackName: track.name!,
                            albumName: track.album!,
                            artwork: track.artwork)
                    }
                case RdioEPSSPaused.value:
                    playbackState = .Paused
                case RdioEPSSStopped.value:
                    playbackState = .Stopped
                    currentTrack = nil
                default:
                    break
                }
            }
        }
    }

}
