//
//  OverviewViewController.swift
//  Emcee
//
//  Created by Simon Støvring on 29/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import Alamofire
import LastFMKit

class OverviewViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    
    private let rowIdentifier = "TopRow"
    private var topArtistsRequest: Alamofire.Request?
    private var topArtists: [Artist]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTopArtists()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        loadTopArtists()
    }
    
    private func loadTopArtists() {
        if topArtistsRequest == nil {
            let username = Preferences().lastFMUsername!
            topArtistsRequest = getLastFMClient().getTopArtists(username, period: .Overall, limit: 5, completion: { [weak self] artists, error in
                if let this = self {
                    this.topArtistsRequest = nil

                    if let artists = artists {
                        this.topArtists = artists
                        this.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return topArtists?.count ?? 0
    }
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let view = tableView.makeViewWithIdentifier(rowIdentifier, owner: nil) as TopTableRowView
        let artist = topArtists![row]
        view.titleLabel.stringValue = artist.name
        view.detailLabel.stringValue = "\(artist.playcount) plays"

        if let image = artist.largestImage() {
            view.setImageWithURL(image.url)
        }
        
        return view
    }
    
}
