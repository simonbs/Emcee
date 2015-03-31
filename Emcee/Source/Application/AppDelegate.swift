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
    internal let panelController: PanelController
    internal let lastFMClient = LastFMKit.Client(apiKey: "01b8faa134fd09c93bb5a64c83516b20", secret: "c5db3db17beb4fce4b568bf10aac6ee1")
    
    private let playersAgent = PlayersAgent()
    private var activePlayer: Player?
    private var clearNotificationCenterTimer: NSTimer?
    private let themeChangedNotification = "AppleInterfaceThemeChangedNotification"
    
    override init() {
        let statusBar = NSStatusBar.systemStatusBar();
        let length: CGFloat = -1 // NSVariableStatusItemLength
        let item = statusBar.statusItemWithLength(length);
        statusItemView = StatusItemView(item: item)
        let storyboard = NSStoryboard(name: "PanelStoryboard", bundle: NSBundle.mainBundle())
        panelController = storyboard?.instantiateInitialController() as PanelController
        super.init()
        statusItemView.style = isStatusBarDark() ? .Light : .Dark
        playersAgent.delegate = self
        statusItemView.delegate = self
    }
    
    func applicationWillFinishLaunching(notification: NSNotification) {
        NSAppleEventManager.sharedAppleEventManager().setEventHandler(self, andSelector: Selector("handleURLEvent:withReplyEvent:"), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let notificationCenter = NSDistributedNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("interfaceThemeChanged:"), name: themeChangedNotification, object: nil)
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
    
    func statusItemViewClicked(view: StatusItemView) {
        if panelController.visible {
            panelController.hidePanel(animated: true)
        } else {
            panelController.showPanel()
        }
    }
    
    func statusItemViewRightClicked(view: StatusItemView) {
        panelController.showPanel(animated: true)
        
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
        statusItemView.text = "\(track.artistName) - \(track.trackName)"
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
        
        clearNotificationCenterTimer = NSTimer.scheduledTimerWithTimeInterval(7, target: self, selector: Selector("clearNotificationCenter"), userInfo: nil, repeats: false)
    }
    
    func clearNotificationCenter() {
        NSUserNotificationCenter.defaultUserNotificationCenter().removeAllDeliveredNotifications()
    }
    
    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
    
    func handleURLEvent(event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
        if let absoluteURL = event.paramDescriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue {
            if let url = NSURL(string: absoluteURL) {
                handleURLScheme(url)
            }
        }
    }
    
    func handleURLScheme(url: NSURL) {
        if url.host == "auth" && url.path == "/callback" {
            handleAuthCallback(url)
        }
    }
    
    func handleAuthCallback(url: NSURL) {
        if let params = url.queryParameters {
            if let token = params["token"] {
                Preferences().lastFMToken = token
                NSNotificationCenter.defaultCenter().postNotificationName(DidConnectToLastFMNotification, object: nil)
                panelController.showPanel(animated: true)
            }
        }
    }
    
}

