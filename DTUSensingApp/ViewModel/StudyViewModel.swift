//
//  StudyViewModel.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import DTUSenseCore


class StudyViewModel : SwitchWithTextViewPresentable {
    var sensor : Sensor!
    var sensors : [Sensor] = []
    let senseKit = DTUSenceKit.sharedInstance
    
    
    init(withSensor sensor: Sensor) {
        self.sensors.append(sensor)
    }
    
//    func activateSensor() {
//        if senseKit.isSensorAvailable(sensor: .Accelerometer){
//            let config : DTUAccelerometerConfiguration = DTUAccelerometerConfiguration()
//            config.sampleRate = 5.0
//            senseKit.registerSensor(sensor: .Accelerometer, withConfig: config)
//            let accelerometer = Accelerometer()
//            accelerometer.id = SensorType.Accelerometer.rawValue
//
//            self.study.sensors.append(accelerometer)
//
//            senseKit.subscribeToSensor(sensorType: .Accelerometer, handler: { (sensorType, data) in
//                let accelerometerData : DTUAccelerometerData = data as! DTUAccelerometerData
//                print("\(sensorType!.rawValue) ---- \(accelerometerData.acceleration!)")
//                
//                //Create sensor and add to study
//                accelerometer.accelaration_x = (accelerometerData.acceleration?.x)!
//                accelerometer.accelaration_y = (accelerometerData.acceleration?.y)!
//                accelerometer.accelaration_z = (accelerometerData.acceleration?.z)!
//                
//                
//                
//            })
//            senseKit.startContinuousSensingWithSensor(sensorType: .Gyroscope)
//        }
//    }
    
    
}


extension StudyViewModel  {
    
    var text: String {
        if sensors.last?.type == .Accelerometer {
            return "Accelerometer"
        }else if sensors.last?.type == .Gyroscope {
            return "Gyroscope"
        }else{
            return "Undefined"
        }
    }
    
    var textColor: UIColor { return .black }
    var font: UIFont { return .systemFont(ofSize: 17.0) }
    
}


extension StudyViewModel  {
    var switchOn: Bool { return false }
    var switchColor: UIColor { return .yellow }
    
    func onSwitchToggleOn(on: Bool) {
        if on {
            print("Accelerometer Active")
        } else {
            print("Accelerometer Inactive")
        }
    }
}
