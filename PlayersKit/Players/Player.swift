//
//  Player.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 22/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

public struct Track: Equatable {
    public let artistName: String
    public let trackName: String
}

public func ==(lhs: Track, rhs: Track) -> Bool {
    return lhs.artistName == rhs.artistName && lhs.trackName == rhs.trackName
}

public protocol PlayerDelegate {
    func playerDidChangeTrack(player: Player, track: Track)
    func playerDidPlay(player: Player)
    func playerDidPause(player: Player)
    func playerDidStop(player: Player)
}

public enum PlaybackState: String {
    case Playing = "Playing"
    case Paused = "Paused"
    case Stopped = "Stopped"
}

public protocol Player {
    class var bundleIdentifier: String { get }
    var playerBundleIdentifier: String { get }
    var delegate: PlayerDelegate? { get set }
    var isStarted: Bool { get }
    var currentTrack: Track? { get }
    var playbackState: PlaybackState { get }
    func start()
    func stop()
}
