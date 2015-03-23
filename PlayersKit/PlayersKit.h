//
//  PlayersKit.h
//  PlayersKit
//
//  Created by Simon Støvring on 22/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for PlayersKit.
FOUNDATION_EXPORT double PlayersKitVersionNumber;

//! Project version string for PlayersKit.
FOUNDATION_EXPORT const unsigned char PlayersKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <PlayersKit/PublicHeader.h>
typedef enum SpotifyEPlS {
    SpotifyEPlSStopped = 'kPSS',
    SpotifyEPlSPlaying = 'kPSP',
    SpotifyEPlSPaused = 'kPSp'
} SpotifyEPlS;

typedef enum iTunesEPlS {
    iTunesEPlSStopped = 'kPSS',
    iTunesEPlSPlaying = 'kPSP',
    iTunesEPlSPaused = 'kPSp',
    iTunesEPlSFastForwarding = 'kPSF',
    iTunesEPlSRewinding = 'kPSR'
} iTunesEPlS;

typedef enum RdioEPSS {
    RdioEPSSPaused = 'kPSp',
    RdioEPSSPlaying = 'kPSP',
    RdioEPSSStopped = 'kPSS'
} RdioEPSS;

typedef enum RdioERep {
    RdioERepNone = 'kReN' /* Do not repeat */,
    RdioERepOne = 'kReO' /* Repeat the currently playing track */,
    RdioERepAll = 'kReA' /* Repeat the currently playing source (i.e. album, playlist) */
} RdioERep;