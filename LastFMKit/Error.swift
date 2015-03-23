//
//  LastFMError.swift
//  Emcee
//
//  Created by Simon Støvring on 23/03/15.
//  Copyright (c) 2015 SimonBS. All rights reserved.
//

import Cocoa

public class Error {

    private class var errorDomain: String { return "dk.simonbs.LastFMKit.Error" }
    
    public enum Code: Int {
        case InvalidService = 2
        case InvalidMethod = 3
        case AuthenticationFailed = 4
        case InvalidFormat = 5
        case InvalidParameters = 6
        case InvalidResourceSpecified = 7
        case OperationFailed = 8
        case InvalidSessionKey = 9
        case InvalidAPIKey = 10
        case ServiceOffline = 11
        case SubscribersOnly = 12
        case InvalidMethodSignatureSupplied = 13
        case UnauthorizedToken = 14
        case ItemNotAvailableForStreaming = 15
        case ServiceTemporarilyUnavailable = 16
        case LoginRequired = 17
        case TrialExpires = 18
        case NotEnoughContent = 20
        case NotEnoughMembers = 21
        case NotEnoughFans = 22
        case NotEnoughNeighbours = 23
        case NoPeakRadio = 24
        case RadioNotFound = 25
        case APIKeySuspended = 26
        case Deprecated = 27
        case RateLimitExceeded = 29
    }
    
    internal class func createError(jsonResponse: [String: AnyObject]) -> NSError? {
        if let error = jsonResponse["error"] as? Int {
            if let errorCode = Error.Code(rawValue: error) {
                let message = errorMessage(errorCode)
                let userInfo = [ NSLocalizedDescriptionKey: message ]
                return NSError(domain: errorDomain, code: errorCode.rawValue, userInfo: userInfo)
            }
        }
        
        return nil
    }
    
    internal class func errorMessage(code: Error.Code) -> String {
        switch code {
        case .InvalidService:
            return "This service does not exist"
        case .InvalidMethod:
            return "No method with that name in this package"
        case .AuthenticationFailed:
            return "You do not have permissions to access the service"
        case .InvalidFormat:
            return "This service doesn't exist in that format"
        case .InvalidParameters:
            return "Your request is missing a required parameter"
        case .InvalidResourceSpecified:
            return " Invalid resource specified"
        case .OperationFailed:
            return "Most likely the backend service failed. Please try again."
        case .InvalidSessionKey:
            return "Please re-authenticate"
        case .InvalidAPIKey:
            return "You must be granted a valid key by last.fm"
        case .ServiceOffline:
            return "This service is temporarily offline. Try again later."
        case .SubscribersOnly:
            return "This station is only available to paid last.fm subscribers"
        case .InvalidMethodSignatureSupplied:
            return "Invalid method signature supplied"
        case .UnauthorizedToken:
            return "This token has not been authorized"
        case .ItemNotAvailableForStreaming:
            return "This item is not available for streaming."
        case .ServiceTemporarilyUnavailable:
            return "The service is temporarily unavailable, please try again."
        case .LoginRequired:
            return "User requires to be logged in"
        case .TrialExpires:
            return "This user has no free radio plays left. Subscription required."
        case .NotEnoughContent:
            return "There is not enough content to play this station"
        case .NotEnoughMembers:
            return "This group does not have enough members for radio"
        case .NotEnoughFans:
            return "This artist does not have enough fans for for radio"
        case .NotEnoughNeighbours:
            return "There are not enough neighbours for radio"
        case .NoPeakRadio:
            return "This user is not allowed to listen to radio during peak usage"
        case .RadioNotFound:
            return "Radio station not found"
        case .APIKeySuspended:
            return "This application is not allowed to make requests to the web services"
        case .Deprecated:
            return "This type of request is no longer supported"
        case .RateLimitExceeded:
            return "Your IP has made too many requests in a short period, exceeding our API guidelines"
        default:
            break
        }
        
        return "Unknown error"
    }
}