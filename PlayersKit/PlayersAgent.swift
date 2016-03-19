//
//  PlayersAgent.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 22/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

public protocol PlayersAgentDelegate {
    func playersAgentDidAddPlayer(agent: PlayersAgent, player: Player)
    func playersAgentDidRemovePlayer(agent: PlayersAgent, player: Player)
}

public class PlayersAgent: NSObject {
    
    public var delegate: PlayersAgentDelegate?
    public private(set) var runningPlayers = [Player]()
    private let supportedBundleIdentifiers = [
        SpotifyPlayer.bundleIdentifier,
        iTunesPlayer.bundleIdentifier,
        RdioPlayer.bundleIdentifier
    ]
   
    public override init() {
        super.init()
        let workspaceNotificationCenter = NSWorkspace.sharedWorkspace().notificationCenter
        workspaceNotificationCenter.addObserver(self, selector: Selector("didLaunchApplication:"), name: NSWorkspaceDidLaunchApplicationNotification, object: nil)
        workspaceNotificationCenter.addObserver(self, selector: Selector("didTerminateApplication:"), name: NSWorkspaceDidTerminateApplicationNotification, object: nil)
        addRunningPlayers()
    }
    
    deinit {
        NSWorkspace.sharedWorkspace().notificationCenter.removeObserver(self)
    }
    
    private func addRunningPlayers() {
        let runningApplications = NSWorkspace.sharedWorkspace().runningApplications
        runningApplications.forEach { app in
            if let bundleIdentifier = app.bundleIdentifier {
                if isSupportedBundleIdentifier(bundleIdentifier) {
                    addPlayerWithBundleIdentifier(bundleIdentifier)
                }
            }
        }
    }
    
    private func playerForBundleIdentifier(bundleIdentifier: String) -> Player? {
        switch bundleIdentifier {
        case SpotifyPlayer.bundleIdentifier:
            return SpotifyPlayer()
        case iTunesPlayer.bundleIdentifier:
            return iTunesPlayer()
        case RdioPlayer.bundleIdentifier:
            return RdioPlayer()
        default:
            break
        }
        
        return nil
    }
    
    private func isSupportedBundleIdentifier(bundleIdentifier: String) -> Bool {
        return supportedBundleIdentifiers.contains(bundleIdentifier)
    }
    
    private func addPlayerWithBundleIdentifier(bundleIdentifier: String) {
        if runningPlayerWithBundleIdentifier(bundleIdentifier) == nil {
            if let player = playerForBundleIdentifier(bundleIdentifier) {
                runningPlayers.append(player)
                delegate?.playersAgentDidAddPlayer(self, player: player)
            }
        }
    }
    
    private func removePlayerWithBundleIdentifier(bundleIdentifier: String) {
        if let player = runningPlayerWithBundleIdentifier(bundleIdentifier) {
            player.stop()
            runningPlayers = runningPlayers.filter({ p in p.playerBundleIdentifier != bundleIdentifier })
            delegate?.playersAgentDidRemovePlayer(self, player: player)
        }
    }
    
    private func runningPlayerWithBundleIdentifier(bundleIdentifier: String) -> Player? {
        return runningPlayers.filter({ p in p.playerBundleIdentifier == bundleIdentifier }).first
    }
    
    private func bundleIdentifierFromApplicationInNotification(notification: NSNotification) -> String? {
        if let userInfo = notification.userInfo {
            if let application = userInfo[NSWorkspaceApplicationKey] as? NSRunningApplication {
                return application.bundleIdentifier
            }
        }
        
        return nil
    }
    
    public func didLaunchApplication(notification: NSNotification) {
        if let bundleIdentifier = bundleIdentifierFromApplicationInNotification(notification) {
            if isSupportedBundleIdentifier(bundleIdentifier) {
                addPlayerWithBundleIdentifier(bundleIdentifier)
            }
        }
    }
    
    public func didTerminateApplication(notification: NSNotification) {
        if let bundleIdentifier = bundleIdentifierFromApplicationInNotification(notification) {
            if isSupportedBundleIdentifier(bundleIdentifier) {
                removePlayerWithBundleIdentifier(bundleIdentifier)
            }
        }
    }
    
}
