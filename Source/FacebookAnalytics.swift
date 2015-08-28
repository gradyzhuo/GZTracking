//
//  FacebookAppEvent.swift
//  Flingy
//
//  Created by Grady Zhuo on 6/24/15.
//  Copyright (c) 2015 Skytiger Studio. All rights reserved.
//

import Foundation
import FBSDKCoreKit

public class FacebookAnalytics : GZTrackingService {

    public var identifier:String {
        return "Facebook"
    }
    
    required public init(token:String = ""){
        FBSDKAppEvents.setFlushBehavior(.Auto)
    }
    
    public func screen(trackingData : GZScreenTrackingData) {
        FBSDKAppEvents.logEvent(trackingData.screenName, parameters: trackingData.properties.dataDict)
    }
    
    public func track(trackingData : GZEventTrackingData) {
        FBSDKAppEvents.logEvent(trackingData.eventName, parameters: trackingData.properties.dataDict)
    }
    
    public func identify(trackingData : GZMemberTrackingData) {
        FBSDKAppEvents.logEvent(FBSDKAppEventNameCompletedRegistration, parameters: trackingData.memberTraits.dataDict)
    }
    
    
    public func resetTracking() {
        
    }
    
    public func enableTracking() {
        FBSDKAppEvents.setFlushBehavior(.Auto)
    }
    
    public func disableTracking() {
        FBSDKAppEvents.setFlushBehavior(.ExplicitOnly)
    }
    
}