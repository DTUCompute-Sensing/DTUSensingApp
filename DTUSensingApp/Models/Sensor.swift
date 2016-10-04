//
//  Sensor.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import RealmSwift

public enum SensorType : String {
    case Battery
    case Accelerometer
    case Gyroscope
    case Magnetometer
}


class Sensor: Object {
    
    dynamic var stydyID = ""
    dynamic var id = ""
    dynamic var date : NSDate?
    var type : SensorType!
}
