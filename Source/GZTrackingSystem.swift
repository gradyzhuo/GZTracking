//
//  GZTrackingSystem.swift
//  Flingy
//
//  Created by Grady Zhuo on 12/3/14.
//  Copyright (c) 2014 Grady Zhuo. All rights reserved.
//

import Foundation

public func == (lhs: GZTrackingService, rhs: GZTrackingService) -> Bool {
    return lhs.identifier == rhs.identifier
}

public class GZTrackingSystem {
    
    public internal(set) var services:[String : GZTrackingService] = [:]
    
    public internal(set) var currentScreenTrackingData:GZScreenTrackingData!
    
    internal static let singleton:GZTrackingSystem = GZTrackingSystem()
    
    public class var defaultSystem:GZTrackingSystem{
        return singleton
    }

    internal func configureServices(services:[GZTrackingService])->GZTrackingSystem{
        
        let registerService = self.registerService
        services.map{ registerService($0) }
        
        return self
    }
    
    
    public func registerService(service:GZTrackingService)->GZTrackingSystem{
        self.services[service.identifier] = service
        return self
    }
    
    public func unregisterService(service:GZTrackingService)->GZTrackingSystem{
        self.unregisterService(forIdentifier: service.identifier)
        return self
    }
    
    public func unregisterService(forIdentifier identifier:String)->GZTrackingSystem{
        self.services.removeValueForKey(identifier)
        return self
    }
    
    //complete
    
    public func enterScreen(screenName:String, properties:GZTrackingProperty = GZTrackingProperty()){
        
        let trackingData = GZScreenTrackingData(screenName: screenName)
        
        self.currentScreenTrackingData = trackingData
        
        trackingData.addProperties(properties)
        
        self.screen(trackingData)
    }
    
    public func sendEvent(eventName:String, properties:GZTrackingProperty = GZTrackingProperty()){
        
        let trackingData = GZEventTrackingData(eventName: eventName)
        
        trackingData.addProperties(properties)
        
        self.track(trackingData)
        
    }
    
    public func registerMember(member:GZTrackingMember){
        let traits = GZTrackingMemberTraits(member: member)
        let trackingData = GZMemberTrackingData(memberTraits: traits)
        
        self.identify(trackingData)
        
    }
    
    public func registerMemberTraits(memberTraits:GZTrackingMemberTraits){
        let trackingData = GZMemberTrackingData(memberTraits: memberTraits)
        
        self.identify(trackingData)
        
    }
    
}


//MARK: - Pattern Support

extension GZTrackingSystem {
    
    public func resetTracking(){
        for (_, value) in self.services {
            value.resetTracking()
        }
    }
    
    public func enableTracking(){
        for (_, value) in self.services {
            value.enableTracking()
        }
    }
    
    
    public func disableTracking(){
        for (_, value) in self.services {
            value.disableTracking()
        }
    }
    
    
    //MARK: - APIs for sending to Mixpanel or Segment.io
    
    internal func screen(trackingData : GZScreenTrackingData){
        for (_, value) in self.services {
            value.screen(trackingData)
        }
    }
    
    internal func track(trackingData : GZEventTrackingData){
        for (_, value) in self.services {
            value.track(trackingData)
        }
    }
    
    internal func identify(trackingData : GZMemberTrackingData){
        for (_, value) in self.services {
            value.identify(trackingData)
        }
    }
}


