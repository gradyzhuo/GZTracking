//
//  GYTrackingSystemPattern.swift
//  
//
//  Created by Grady Zhuo on 6/24/15.
//
//

import UIKit

public protocol GZTrackingService {
    
    init()
    
    func screen(trackingData : GZScreenTrackingData)
    func track(trackingData : GZEventTrackingData)
    func identify(trackingData : GZMemberTrackingData)
    
    
    //State's changes.
    func resetTracking()
    func enableTracking()
    func disableTracking()
    
}


