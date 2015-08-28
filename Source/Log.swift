//
//  Log.swift
//  GZTracking
//
//  Created by Grady Zhuo on 8/29/15.
//  Copyright (c) 2015 Grady Zhuo. All rights reserved.
//

import Foundation

func GZLog(object:AnyObject!, prefix:String = "") {
    #if DEBUG
    println("[\(prefix)]:\(object)")
    #else
    #endif
    
}

func GZTrackingLog(object:AnyObject!) {
    
    GZLog(object, prefix:"Tracking")
    
}