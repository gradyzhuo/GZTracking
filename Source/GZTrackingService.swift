//
//  GYTrackingSystemPattern.swift
//  
//
//  Created by Grady Zhuo on 6/24/15.
//
//

import UIKit

public protocol GZTrackingService {
    
    var identifier:String { get }
    
    init(token:String)
    
    func screen(trackingData : GZScreenTrackingData)
    func track(trackingData : GZEventTrackingData)
    func identify(trackingData : GZMemberTrackingData)
    
    
    //State's changes.
    func resetTracking()
    func enableTracking()
    func disableTracking()
    
}

public class GZTrackingSystemDefaultService {
    class func Facebook()->GZTrackingService{
        return FacebookAnalytics()
    }
    
    class func Mixpanel(token:String)->GZTrackingService{
        return MixpanelService(token: token)
    }
}
