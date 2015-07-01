//
//  GZTrackingSystem.swift
//  Flingy
//
//  Created by Grady Zhuo on 12/3/14.
//  Copyright (c) 2014 Grady Zhuo. All rights reserved.
//

import Foundation

public enum GZService : Equatable {
    
    case Service(identifier:String, service:GZTrackingService)
    
    var service : GZTrackingService {
        switch self{
        case let .Service(_, service):
            return service
        }
    }
    
    var identifier : String {
        switch self{
        case let .Service(identifier, _):
            return identifier
        }
    }
    
    public static var Facebook : GZService = GZService.Service(identifier: "Facebook", service: FacebookAnalytics())
    
}

public func == (lhs: GZService, rhs: GZService) -> Bool {
    return lhs.identifier == rhs.identifier
}

public class GZTrackingSystem {
    
    public internal(set) var services:[GZTrackingService] = []
    
    public internal(set) var currentScreenTrackingData:GZScreenTrackingData!
    
    internal static let singleton:GZTrackingSystem = GZTrackingSystem()
    
    public class var defaultSystem:GZTrackingSystem{
        return singleton
    }
    
    internal init(){
        self.configureServices([.Facebook])
    }
    
    public func configureServices(services:[GZService])->GZTrackingSystem{
        
        self.services = services.map{ $0.service }
        
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
        self.services.map{ $0.resetTracking() }
    }
    
    public func enableTracking(){
        self.services.map{ $0.enableTracking() }
    }
    
    
    public func disableTracking(){
        self.services.map{ $0.disableTracking() }
    }
    
    
    //MARK: - APIs for sending to Mixpanel or Segment.io
    
    internal func screen(trackingData : GZScreenTrackingData){
        self.services.map{ $0.screen(trackingData) }
    }
    
    internal func track(trackingData : GZEventTrackingData){
        self.services.map{ $0.track(trackingData) }
    }
    
    internal func identify(trackingData : GZMemberTrackingData){
        self.services.map{ $0.identify(trackingData) }
    }
    
}


