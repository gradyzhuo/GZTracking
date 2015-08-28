//
//  GZTrackingData.swift
//  Flingy
//
//  Created by Grady Zhuo on 6/24/15.
//  Copyright (c) 2015 Skytiger Studio. All rights reserved.
//

import Foundation

public class GZTrackingData {
    
    public let properties:GZTrackingProperty = GZTrackingProperty()

    
    public init(){
        
    }
    
    public init(properties:GZTrackingProperty){
        self.properties.addProperty(properties)
    }
    
    public func addProperties(properties:GZTrackingProperty){
        self.properties.addProperty(properties)
    }

    public func removeProperty(property:GZTrackingProperty){
        self.properties.removeProperties(property)
    }
    
    public func willMoveToTrackingSystem(){
        
    }
    
}



public class GZScreenTrackingData:GZTrackingData{
    
    public var screenName:String
    
    public init(screenName:String) {
        
        self.screenName = screenName
        
        super.init()
    }
    
    
}



public class GZEventTrackingData:GZTrackingData{
    
    public var eventName:String
    
    public init(eventName:String) {
        
        self.eventName = eventName
        
        super.init()
    }
    
}


public class GZMemberTrackingData:GZTrackingData {
    
    public let memberId:String
    public let memberTraits : GZTrackingMemberTraits
    
    public init(memberTraits:GZTrackingMemberTraits){
        self.memberTraits = memberTraits
        self.memberId = memberTraits.member.trackingId.value
        
        super.init()
        
        self.addProperties(memberTraits)

    }
    
    
}
