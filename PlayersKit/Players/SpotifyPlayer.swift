//
//  SpotifyPlayer.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 22/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import ScriptingBridge

public class SpotifyPlayer: BasePlayer {
   
    override public class var bundleIdentifier: String { return "com.spotify.client" }
    override public var playerBundleIdentifier: String { return SpotifyPlayer.bundleIdentifier }
    
    private let playbackStateChangedNotification = "com.spotify.client.PlaybackStateChanged"
    private let spotify: SpotifyApplication = SBApplication(bundleIdentifier: SpotifyPlayer.bundleIdentifier)

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
        if (spotify as SBApplication).running {
            if let playerState = spotify.playerState {
                switch playerState.value {
                case SpotifyEPlSPlaying.value:
                    playbackState = .Playing
                    if let spotifyTrack = spotify.currentTrack {
                        currentTrack = Track(artistName: spotifyTrack.artist!, trackName: spotifyTrack.name!)
                    }
                case SpotifyEPlSPaused.value:
                    playbackState = .Paused
                case SpotifyEPlSStopped.value:
                    playbackState = .Stopped
                    currentTrack = nil
                default:
                    break
                }
            }
        }
    }
    
}

