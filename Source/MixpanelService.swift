//
//  Mixpanel.swift
//  Flingy
//
//  Created by Grady Zhuo on 8/19/15.
//  Copyright (c) 2015 Skytiger Studio. All rights reserved.
//

import Foundation
import UIKit
import Mixpanel

public class MixpanelService: NSObject, GZTrackingService, MixpanelDelegate {
    
    private var instance:Mixpanel?
    
    var token:String?
    
    public var identifier:String {
        return "Mixpanel"
    }
    
    required public init(token:String){
        super.init()
        
        self.instance = Mixpanel.sharedInstanceWithToken(token)
        self.instance?.delegate = self
    }
    
    public func screen(trackingData : GZScreenTrackingData){
        
        self.instance?.track("Viewed " + trackingData.screenName, properties: trackingData.properties.dataDict)
        
        if let previousScreen = GZTrackingSystem.defaultSystem.previousScreen{
            if previousScreen.screenName != trackingData.screenName {
                self.instance?.track("Duration " + previousScreen.screenName, properties: trackingData.properties.dataDict)
            }
        }
        
        self.instance?.timeEvent("Duration " + trackingData.screenName)
        
        GZTrackingLog("screen pageName:\(trackingData.screenName) properties:\(trackingData.properties.dataDict) ")
    }
    
    public func track(trackingData : GZEventTrackingData){
        
        self.instance?.track(trackingData.eventName, properties: trackingData.properties.dataDict)
        GZTrackingLog("track event:\(trackingData.eventName) properties:\(trackingData.properties.dataDict) ")
    }
    
    public func identify(trackingData : GZMemberTrackingData){
        
        self.instance?.identify(trackingData.memberId)
        self.instance?.people.set(trackingData.memberTraits.dataDict)
        
        GZTrackingLog("identify userId:\(trackingData.memberId) traits:\(trackingData.memberTraits) ")
    }
    
    
    //State's changes.
    public func resetTracking(){
        self.instance?.reset()
    }
    
    public func enableTracking(){
        self.instance = Mixpanel.sharedInstance()
    }
    
    public func disableTracking(){
        self.instance = nil
    }
    
    public func mixpanelWillFlush(mixpanel: Mixpanel!) -> Bool {
        return true
    }
    
}