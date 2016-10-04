//
//  Magnetometer.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 10/4/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import RealmSwift

class Magnetometer: Sensor {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var magnatic_x : Double = 0.0
    dynamic var magnatic_y : Double = 0.0
    dynamic var magnatic_z : Double = 0.0
    
}
