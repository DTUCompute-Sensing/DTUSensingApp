//
//  Gyroscope.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/22/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import RealmSwift

class Gyroscope: Sensor {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    dynamic var rotation_x : Double = 0.0
    dynamic var rotation_y : Double = 0.0
    dynamic var rotation_z : Double = 0.0
    
    
}
