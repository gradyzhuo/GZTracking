//
//  GZTrackingProperty.swift
//  Flingy
//
//  Created by Grady Zhuo on 6/24/15.
//  Copyright (c) 2015 Skytiger Studio. All rights reserved.
//

import Foundation

//MARK: - GZTrackingConfig

public class GZTrackingProperty {
    
    public var dataDict:[String:AnyObject]{
        return self.convertToDataDict()
    }
    
    public internal(set) var properties:[GZTrackingProperty] = []
    
    public var key:String!
    public var value:String = ""
    
    public init(){
        self.key = nil
        self.properties.append(self)
    }
    
    public init(key:String, value:String?){

        self.key = key
        self.value = value ?? ""
        
        self.properties.append(self)
        
    }
    
    public convenience init(dataDict:[String:String]){
        self.init()
        
        for (key, value) in dataDict {
            self.addProperty(GZTrackingProperty(key: key, value: value))
        }
        
    }
    
    public func addProperty(otherConfig:GZTrackingProperty){
        self.properties.extend(otherConfig.properties)
    }
    
    public func removeProperties(property:GZTrackingProperty){
        self.properties = self.properties.filter({ (aProperty:GZTrackingProperty) -> Bool in
            return aProperty.key == property.key
        })
    }
    
    private func convertToDataDict()->[String:AnyObject]{
        
        var dataDict = [String:AnyObject]()
        
        for property in self.properties {
            
            if let key = property.key {
                dataDict[key] = property.value
            }

        }
        
        return dataDict
    }
    
    
}



public protocol GZTrackingMember {
    var trackingId:GZTrackingProperty { get }
    var trackingName:GZTrackingProperty? { get }
    var trackingEmail:GZTrackingProperty? { get }
    var trackingUserInfo:[GZTrackingProperty] { get }
}

public class GZTrackingMemberTraits:GZTrackingProperty {
    
    public internal(set) var member:GZTrackingMember!
    
    public init(member:GZTrackingMember) {
        super.init()
        
        self.addProperty(member.trackingId)
        
        if let name = member.trackingName {
            self.addProperty(name)
        }
        
        if let email = member.trackingEmail {
            self.addProperty(email)
        }
        
        for property in member.trackingUserInfo {
            self.addProperty(property)
        }
        
        self.member = member
        
    }
    
}

