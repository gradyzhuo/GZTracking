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
    
    var identifier:String {
        return "Mixpanel"
    }
    
    required init(token:String){
        super.init()
        
        self.instance = Mixpanel.sharedInstanceWithToken(token)
        self.instance?.delegate = self
    }
    
    func screen(trackingData : GZScreenTrackingData){
        
        self.instance?.track("Viewed " + trackingData.screenName, properties: trackingData.properties.dataDict)
        
        if let previousScreen = GZTrackingSystem.defaultSystem.previousScreen{
            if previousScreen.screenName != trackingData.screenName {
                self.instance?.track("Duration " + previousScreen.screenName, properties: trackingData.properties.dataDict)
            }
        }
        
        self.instance?.timeEvent("Duration " + trackingData.screenName)
        
        GYTrackingLog("screen pageName:\(trackingData.screenName) properties:\(trackingData.properties.dataDict) ")
    }
    
    func track(trackingData : GZEventTrackingData){
        
        self.instance?.track(trackingData.eventName, properties: trackingData.properties.dataDict)
        GYTrackingLog("track event:\(trackingData.eventName) properties:\(trackingData.properties.dataDict) ")
    }
    
    func identify(trackingData : GZMemberTrackingData){
        
        self.instance?.identify(trackingData.memberId)
        self.instance?.people.set(trackingData.memberTraits.dataDict)
        
        GYTrackingLog("identify userId:\(trackingData.memberId) traits:\(trackingData.memberTraits) ")
    }
    
    
    //State's changes.
    func resetTracking(){
        self.instance?.reset()
    }
    
    func enableTracking(){
        self.instance = Mixpanel.sharedInstance()
    }
    
    func disableTracking(){
        self.instance = nil
    }
    
    func mixpanelWillFlush(mixpanel: Mixpanel!) -> Bool {
        return true
    }
    
}