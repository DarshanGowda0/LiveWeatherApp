//
//  Location.swift
//  LiveWeatherApp
//
//  Created by Darshan Gowda on 02/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    static var sharedInstance = Location()
    
    private init(){}
    
    var latitude : Double!
    var longitude : Double!
    
    
}
