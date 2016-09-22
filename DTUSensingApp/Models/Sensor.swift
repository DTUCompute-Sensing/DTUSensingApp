//
//  Sensor.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import RealmSwift

public enum SensorType:String {
    case Battery
    case Accelerometer
    case Gyroscope
}


class Sensor: Object {
    
    dynamic var id = ""
    var type : SensorType!
}
