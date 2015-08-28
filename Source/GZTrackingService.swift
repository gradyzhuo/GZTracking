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

internal class GZTrackingSystemDefaultService {
//    static var Facebook = FacebookAnalytics(token: nil)
}
