//
//  TopViewController.swift
//  Emcee
//
//  Created by Simon Støvring on 29/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa
import Alamofire
import LastFMKit

protocol TopViewControllerDelegate {
    func topViewControllerDidStartRefresh(controller: TopViewController)
    func topViewControllerDidFinishRefreshing(controller: TopViewController)
}

class TopViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    
    internal var delegate: TopViewControllerDelegate?
    
    private let topRowIdentifier = "TopRow"
    private let headerRowIdentifier = "HeaderRow"
    
    private var topArtistsRequest: Alamofire.Request?
    
    private var topArtists: [Artist]?
    private var sections = Sections<Artist>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
    }
    
    private func refresh() {
        self.delegate?.topViewControllerDidStartRefresh(self)
        loadTopArtists {
            self.delegate?.topViewControllerDidFinishRefreshing(self)
            return
        }
    }
    
    private func loadTopArtists(completion: (() -> ())? = nil) {
        if topArtistsRequest == nil {
            let username = Preferences().lastFMUsername!
            topArtistsRequest = getLastFMClient().getTopArtists(username, period: .Overall, limit: 5, completion: { [weak self] artists, error in
                if let this = self {
                    this.topArtistsRequest = nil

                    if let artists = artists {
                        this.topArtists = artists
                        
                        let section = Section<Artist>()
                        section.items = artists
                        this.sections.addSection(section)
                        
                        this.tableView.reloadData()
                    }
                }
                
                completion?()
            })
        }
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return sections.rowCount
    }
    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let view = tableView.makeViewWithIdentifier(topRowIdentifier, owner: nil) as TopTableRowView
        
        if !sections.isHeaderRow(row) {
            
        }
        
        
        let artist = topArtists![row]
        view.titleLabel.stringValue = artist.name
        view.detailLabel.stringValue = "\(artist.playcount) plays"

        if let image = artist.largestImage() {
            view.setImageWithURL(image.url)
        }
        
        return view
    }
    
}
