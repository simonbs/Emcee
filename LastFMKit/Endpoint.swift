//
//  Endpoint.swift
//  Emcee
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

internal enum Endpoint {
    
    internal enum Album: String {
        case AddTags = "album.addtags"
        case GetBuylinks = "album.getbuylinks"
        case GetInfo = "album.getinfo"
        case GetShouts = "album.getshouts"
        case GetTags = "album.gettags"
        case GetTopTags = "album.gettoptags"
        case RemoveTag = "album.removetag"
        case Search = "album.search"
        case Share = "album.share"
    }

    internal enum Artist: String {
        case AddTags = "artist.addtags"
        case GetCorrection = "artist.getcorrection"
        case GetEvents = "artist.getevents"
        case GetInfo = "artist.getinfo"
        case GetPastEvents = "artist.getpastevents"
        case GetPodcast = "artist.getpodcast"
        case GetShouts = "artist.getshouts"
        case GetSimilar = "artist.getsimilar"
        case GetTags = "artist.gettags"
        case GetTopAlbums = "artist.gettopalbums"
        case GetTopFans = "artist.gettopfans"
        case GetTopTags = "artist.gettoptags"
        case GetTopTracks = "artist.gettoptracks"
        case RemoveTag = "artist.removetag"
        case Search = "artist.search"
        case Share = "artist.share"
        case Shout = "artist.shout"
    }
    
    internal enum Auth: String {
        case GetMobileSession = "auth.getmobilesession"
        case GetSession = "auth.getsession"
        case GetToken = "auth.gettoken"
    }
    
    internal enum Chart: String {
        case GetHypedArtists = "chart.gethypedartists"
        case GetHypedTracks = "chart.gethypedtracks"
        case GetLovedTracks = "chart.getlovedtracks"
        case GetTopArtists = "chart.gettopartists"
        case GetTopTags = "chart.gettoptags"
        case GetTopTracks = "chart.gettoptracks"
    }
    
    internal enum Event: String {
        case Attend = "event.attend"
        case GetAttendees = "event.getattendees"
        case GetInfo = "event.getinfo"
        case GetShouts = "event.getshouts"
        case Share = "event.share"
        case Shout = "event.shout"
    }
    
    internal enum Geo: String {
        case GetEvents = "geo.getevents"
        case GetMetroArtistChart = "geo.getmetroartistchart"
        case GetMetroHypeArtistChart = "geo.getmetrohypeartistchart"
        case GetMetroHypeTrackChart = "geo.getmetrohypetrackchart"
        case GetMetroTrackChart = "geo.getmetrotrackchart"
        case GetMetroUniqueArtistChart = "geo.getmetrouniqueartistchart"
        case GetMetroUniqueTrackChart = "geo.getmetrouniquetrackchart"
        case GetMetroWeeklyChartlist = "geo.getmetroweeklychartlist"
        case GetMetros = "geo.getmetros"
        case GetTopArtists = "geo.gettopartists"
        case GetTopTracks = "geo.gettoptracks"
    }
    
    internal enum Group: String {
        case GetHype = "group.gethype"
        case GetMembers = "group.getmembers"
        case GetWeeklyAlbumChart = "group.getweeklyalbumchart"
        case GetWeeklyArtistChart = "group.getweeklyartistchart"
        case GetWeeklyChartlist = "group.getweeklychartlist"
        case GetWeeklyTrackChart = "group.getweeklytrackchart"
    }
    
    internal enum Library: String {
        case AddAlbum = "library.addalbum"
        case AddArtist = "library.addartist"
        case AddTrack = "library.addtrack"
        case GetAlbums = "library.getalbums"
        case GetArtists = "library.getartists"
        case GetTracks = "library.gettracks"
        case RemoveAlbum = "library.removealbum"
        case RemoveArtist = "library.removeartist"
        case RemoveScrobble = "library.removescrobble"
        case RemoveTrack = "library.removetrack"
    }
    
    internal enum Playlist: String {
        case AddTrack = "playlist.addtrack"
        case Create = "playlist.create"
    }
    
    internal enum Radio: String {
        case GetPlaylist = "radio.getplaylist"
        case Search = "radio.search"
        case Tune = "radio.tune"
    }
    
    internal enum Tag: String {
        case GetInfo = "tag.getinfo"
        case GetSimilar = "tag.getsimilar"
        case GetTopAlbums = "tag.gettopalbums"
        case GetTopArtists = "tag.gettopartists"
        case GetTopTags = "tag.gettoptags"
        case GetTopTracks = "tag.gettoptracks"
        case GetWeeklyArtistChart = "tag.getweeklyartistchart"
        case GetWeeklyChartlist = "tag.getweeklychartlist"
        case Search = "tag.search"
    }
    
    internal enum Tasteometer: String {
        case Compare = "tasteometer.compare"
        case CompareGroup = "tasteometer.comparegroup"
    }
    
    internal enum Track: String {
        case AddTags = "track.addtags"
        case Ban = "track.ban"
        case GetBuylinks = "track.getbuylinks"
        case GetCorrection = "track.getcorrection"
        case GetFingerprintMetadata = "track.getfingerprintmetadata"
        case GetInfo = "track.getinfo"
        case GetShouts = "track.getshouts"
        case GetSimilar = "track.getsimilar"
        case GetTags = "track.gettags"
        case GetTopFans = "track.gettopfans"
        case GetTopTags = "track.gettoptags"
        case Love = "track.love"
        case RemoveTag = "track.removetag"
        case Scrobble = "track.scrobble"
        case Search = "track.search"
        case Share = "track.share"
        case Unban = "track.unban"
        case Unlove = "track.unlove"
        case UpdateNowPlaying = "track.updatenowplaying"
    }
    
    internal enum User: String {
        case GetArtistTracks = "user.getartisttracks"
        case GetBannedTracks = "user.getbannedtracks"
        case GetEvents = "user.getevents"
        case GetFriends = "user.getfriends"
        case GetInfo = "user.getinfo"
        case GetLovedTracks = "user.getlovedtracks"
        case GetNeighbours = "user.getneighbours"
        case GetNewReleases = "user.getnewreleases"
        case GetPastEvents = "user.getpastevents"
        case GetPersonalTags = "user.getpersonaltags"
        case GetPlaylists = "user.getplaylists"
        case GetRecentStations = "user.getrecentstations"
        case GetReventTracks = "user.getrecenttracks"
        case GetRecommendations = "user.getrecommendedartists"
        case GetRecommendedEvents = "user.getrecommendedevents"
        case GetShouts = "user.getshouts"
        case GetTopAlbums = "user.gettopalbums"
        case GetTopArtists = "user.gettopartists"
        case GetTopTags = "user.gettoptags"
        case GetTopTracks = "user.gettoptracks"
        case GetWeeklyAlbumChart = "user.getweeklyalbumchart"
        case GetWeeklyArtistChart = "user.getweeklyartistchart"
        case GetWeeklyChartlist = "user.getweeklychartlist"
        case GetWeeklyTrackChart = "user.getweeklytrackchart"
        case Shout = "user.shout"
        case Signup = "user.signup"
        case Terms = "user.terms"
    }
    
    internal enum Venue: String {
        case GetEvents = "venue.getevents"
        case GetPastEvents = "venue.getpastevents"
        case Search = "venue.search"
    }
}
