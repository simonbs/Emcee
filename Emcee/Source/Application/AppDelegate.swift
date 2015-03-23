//
//  AppDelegate.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import PlayersKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, StatusItemViewDelegate, PlayersAgentDelegate, PlayerDelegate {
    
    private let statusItemView: StatusItemView
    private let playersAgent = PlayersAgent()
    private var activePlayer: Player?
    
    override init() {
        let statusBar = NSStatusBar.systemStatusBar();
        let length: CGFloat = -1 // NSVariableStatusItemLength
        let item = statusBar.statusItemWithLength(length);
        statusItemView = StatusItemView(item: item, image: NSImage(named: "statusbar")!)
        super.init()
        playersAgent.delegate = self
        statusItemView.delegate = self
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        usePlayer(playersAgent.runningPlayers.first)
    }
    
    func statusItemViewRightClicked(view: StatusItemView) {
        let quitItem = NSMenuItem(title: "Quit", action: Selector("quitApp:"), keyEquivalent: "Q")
        
        let menu = NSMenu()
        menu.addItem(quitItem)
        view.item.popUpStatusItemMenu(menu)
    }
    
    func quitApp(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func playersAgentDidAddPlayer(agent: PlayersAgent, player: Player) {
        if activePlayer == nil {
            usePlayer(player)
        }
    }
    
    func playersAgentDidRemovePlayer(agent: PlayersAgent, player: Player) {
        if player.playerBundleIdentifier == activePlayer?.playerBundleIdentifier {
            usePlayer(agent.runningPlayers.first)
        }
    }
    
    func playerDidPlay(player: Player) {
        if let track = player.currentTrack {
            displayTrack(track)
        }
    }
    
    func playerDidPause(player: Player) {
        statusItemView.text = nil
    }
    
    func playerDidStop(player: Player) {
        statusItemView.text = nil
    }
    
    func playerDidChangeTrack(player: Player, track: Track) {
        displayTrack(track)
    }
    
    private func usePlayer(player: Player?) {
        if let activePlayer = activePlayer {
            activePlayer.stop()
            self.activePlayer = nil
        }
        
        statusItemView.text = nil
        
        if let player = player {
            activePlayer = player
            activePlayer?.delegate = self
            activePlayer?.start()
        }
    }
    
    private func displayTrack(track: Track) {
        statusItemView.text = "\(track.artistName) - \(track.trackName)"
    }
    
}
