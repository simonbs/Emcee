//
//  Sections.swift
//  Emcee
//
//  Created by Simon Støvring on 03/04/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Foundation

class Section<T> {
    
    internal var hasHeader: Bool = false
    internal var items = [T]()
    internal var rowCount: Int {
        return items.count + (hasHeader ? 1 : 0)
    }
    
}

class Sections<T> {
    
    private var sections = [Section<T>]()
    internal var rowCount: Int {
        return sections.reduce(0, combine: { $0 + $1.rowCount })
    }
    
    internal func addSection(section: Section<T>) {
        sections.append(section)
    }
    
    internal func sectionForRow(row: Int) -> Int? {
        var totalRows = 0
        var s = 0
        var section: Int? = nil
        while totalRows < row {
            totalRows += sections[s].rowCount
            if totalRows >= row {
                section = s
            }
            s++
        }
        
        return section
    }
    
    internal func isHeaderRow(row: Int) -> Bool {
        return false
    }
    
    internal func itemAtRow(row: Int) -> T? {
        let section = sectionForRow(row)
        return nil
    }
    
}
