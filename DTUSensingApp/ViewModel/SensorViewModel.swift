//
//  SensorViewModel.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/23/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit
import RealmSwift
import MessageUI

class SensorViewModel : DetailLabelWithTitlePresentable  {

    var sensor : Sensor? = nil
    var index = 0
    let realm = try! Realm()
    
    init(withSensor sensor : Sensor) {
        self.sensor = sensor
    }
    
    func getObjectCount() -> Int {
    
        switch sensor!.type! {
        case .Accelerometer:
            return  realm.objects(Accelerometer.self).count
        case .Gyroscope:
            return  realm.objects(Gyroscope.self).count
        case .Magnetometer:
            return  realm.objects(Magnetometer.self).count
        default:
            return 0
        }
    }
}



extension SensorViewModel  {

    var text: String {
        switch sensor!.type! {
        case .Accelerometer:
            let values = realm.objects(Accelerometer.self)
            let value = values[index] as Accelerometer
            let x = Double(round(100000*value.accelaration_x)/100000)
            let y = Double(round(100000*value.accelaration_y)/100000)
            let z = Double(round(100000*value.accelaration_z)/100000)
            return "x : \(x) y : \(y) z : \(z)"
        case .Gyroscope:
            let values = realm.objects(Gyroscope.self)
            let value = values[index] as Gyroscope
            let x = Double(round(100000*value.rotation_x)/100000)
            let y = Double(round(100000*value.rotation_y)/100000)
            let z = Double(round(100000*value.rotation_z)/100000)
            return "x : \(x) y : \(y) z : \(z)"
        case .Magnetometer:
            let values = realm.objects(Magnetometer.self)
            let value = values[index] as Magnetometer
            let x = Double(round(100000*value.magnatic_x)/100000)
            let y = Double(round(100000*value.magnatic_y)/100000)
            let z = Double(round(100000*value.magnatic_z)/100000)
            return "x : \(x) y : \(y) z : \(z)"
        default:
            return ""
        }
    }
    var textColor: UIColor { return .black }
    var font: UIFont { return .systemFont(ofSize: 12.0) }
    
}


extension SensorViewModel {
    var detailText: String {return ""}
    var detailTextColor: UIColor {return .black}
    var detailFont: UIFont {return .systemFont(ofSize: 15.0)}
}

