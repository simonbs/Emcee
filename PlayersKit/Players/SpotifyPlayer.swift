//
//  SpotifyPlayer.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 22/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation
import ScriptingBridge
import SwiftyJSON
import Alamofire

public class SpotifyPlayer: BasePlayer {
   
    override public class var bundleIdentifier: String { return "com.spotify.client" }
    override public var playerBundleIdentifier: String { return SpotifyPlayer.bundleIdentifier }
    
    private let playbackStateChangedNotification = "com.spotify.client.PlaybackStateChanged"
    private let spotify: SpotifyApplication = SBApplication(bundleIdentifier: SpotifyPlayer.bundleIdentifier)
    private var artworkTask: NSURLSessionDataTask?
    
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
                    if let track = spotify.currentTrack {
                        setTrackFromSpotifyTrack(track)
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
    
    private func setTrackFromSpotifyTrack(track: SpotifyTrack) {
        if let artworkTask = artworkTask {
            artworkTask.cancel()
        }
        
        if let trackId = track.id?() {
            let url = "https://embed.spotify.com/oembed/"
            let params = [ "url": trackId ]
            Alamofire.request(.GET, url, parameters: params, encoding: .URL).responseJSON { (request, response, jsonResponse, error) in
                if let jsonResponse: AnyObject = jsonResponse {
                    let json = JSON(jsonResponse)
                    if let artworkUrl = json["thumbnail_url"].URL {
                        self.setCurrentTrack(track, artwork: NSImage(contentsOfURL: artworkUrl))
                    }
                } else {
                    self.setCurrentTrack(track)
                }
            }
        } else {
            setCurrentTrack(track)
        }
    }
    
    private func setCurrentTrack(track: SpotifyTrack, artwork: NSImage? = nil) {
        currentTrack = Track(
            artistName: track.artist!,
            trackName: track.name!,
            albumName: track.album!,
            artwork: artwork)
    }
    
}

