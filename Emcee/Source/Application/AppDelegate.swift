//
//  AppDelegate.swift
//  NowScrobbling
//
//  Created by Simon Støvring on 21/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import PlayersKit
import LastFMKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate, StatusItemViewDelegate, PlayersAgentDelegate, PlayerDelegate {
    
    internal let statusItemView: StatusItemView
    
    private let playersAgent = PlayersAgent()
    private var activePlayer: Player?
    private var clearNotificationCenterTimer: NSTimer?
    private let themeChangedNotification = "AppleInterfaceThemeChangedNotification"
    
    override init() {
        let statusBar = NSStatusBar.systemStatusBar();
        let length: CGFloat = -1 // NSVariableStatusItemLength
        let item = statusBar.statusItemWithLength(length);
        statusItemView = StatusItemView(item: item)
        
        super.init()
        statusItemView.style = isStatusBarDark() ? .Light : .Dark
        playersAgent.delegate = self
        statusItemView.delegate = self
    }
    
    func applicationWillFinishLaunching(notification: NSNotification) {
        NSAppleEventManager.sharedAppleEventManager().setEventHandler(self, andSelector: "handleURLEvent:withReplyEvent:", forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "interfaceThemeChanged:", name: themeChangedNotification)
        usePlayer(playersAgent.runningPlayers.first)
    }
    
    func interfaceThemeChanged(notification: NSNotification) {
        statusItemView.style = isStatusBarDark() ? .Light : .Dark
    }
    
    private func isStatusBarDark() -> Bool {
        if let settings = NSUserDefaults.standardUserDefaults().persistentDomainForName(NSGlobalDomain) {
            if let style = settings["AppleInterfaceStyle"] as? String {
                return style == "Dark"
            }
        }
        
        return false
    }
    
    func statusItemViewRightClicked(view: StatusItemView) {
        let quitItem = NSMenuItem(title: "Quit", action: "quitApp:", keyEquivalent: "Q")
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
            notifyTrack(track)
        }
    }
    
    func playerDidPause(player: Player) {
        statusItemView.text = nil
        clearNotificationCenter()
    }
    
    func playerDidStop(player: Player) {
        statusItemView.text = nil
        clearNotificationCenter()
    }
    
    func playerDidChangeTrack(player: Player, track: Track) {
        displayTrack(track)
        notifyTrack(track)
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
        let maxLength = 50
        let text = "\(track.artistName) \(track.trackName)"
       
        let fontSize: CGFloat = 13
        let defaultFont = NSFont.systemFontOfSize(fontSize)
        let defaultAttributes = [ NSFontAttributeName: defaultFont ]
        let trackString = NSAttributedString(string: track.trackName, attributes: defaultAttributes)
        
        if count(text) > maxLength {
            statusItemView.text = trackString
        } else {
            let artistFont = NSFont.boldSystemFontOfSize(fontSize)
            let artistAttributes = [ NSFontAttributeName: artistFont ]
            let attributedString = NSMutableAttributedString(string: track.artistName, attributes: artistAttributes)
            attributedString.appendAttributedString(NSAttributedString(string: " "))
            attributedString.appendAttributedString(trackString)
            statusItemView.text = attributedString
        }
    }
    
    private func notifyTrack(track: Track) {
        let notification = NSUserNotification()
        notification.title = track.trackName
        notification.subtitle = track.albumName
        notification.informativeText = track.artistName
        if let artwork = track.artwork {
            notification.setValue(artwork, forKey: "_identityImage")
        }
        
        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
        
        if let timer = clearNotificationCenterTimer {
            timer.invalidate()
        }
        
        clearNotificationCenterTimer = NSTimer.scheduledTimerWithTimeInterval(7, target: self, selector: "clearNotificationCenter", userInfo: nil, repeats: false)
    }
    
    func clearNotificationCenter() {
        NSUserNotificationCenter.defaultUserNotificationCenter().removeAllDeliveredNotifications()
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
    
}

