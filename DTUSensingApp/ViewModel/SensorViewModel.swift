//
//  SensorViewModel.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/23/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit
import RealmSwift

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
        default:
            return 0
        }
    }
}



extension SensorViewModel  {

    var text: String {return (sensor?.type.rawValue)!}
    var textColor: UIColor { return .black }
    var font: UIFont { return .systemFont(ofSize: 15.0) }
    
    
}


extension SensorViewModel {
    var detailText: String {
        
        switch sensor!.type! {
        case .Accelerometer:
            let values = realm.objects(Accelerometer.self)
            let value = values[index] as Accelerometer
            return "\(value.accelaration_x), \(value.accelaration_y), \(value.accelaration_z)"
        case .Gyroscope:
                let values = realm.objects(Gyroscope.self)
                let value = values[index] as Gyroscope
                return "\(value.rotation_x), \(value.rotation_y), \(value.rotation_z)"
        default:
            return ""
        }

    
    }
    var detailTextColor: UIColor {return .black}
    var detailFont: UIFont {return .systemFont(ofSize: 15.0)}
}

