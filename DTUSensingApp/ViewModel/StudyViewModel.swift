//
//  StudyViewModel.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import DTUSenseCore
import RealmSwift

class StudyViewModel : SwitchWithTextViewPresentable {
    
    var sensors : [String:Sensor] = [:]
    let senseKit = DTUSenceKit.sharedInstance
    let realm = try! Realm()
    
    init(withSensor sensor: Sensor) {
        self.sensors = [sensor.type.rawValue:sensor]
    }
    
    func activateAccelerometerSensor() {
        if senseKit.isSensorAvailable(sensor: .Accelerometer){
            let config : DTUAccelerometerConfiguration = DTUAccelerometerConfiguration()
            config.sampleRate = 5.0
            senseKit.registerSensor(sensor: .Accelerometer, withConfig: config)
            senseKit.subscribeToSensor(sensorType: .Accelerometer, handler: { (sensorType, data) in
                let accelerometerData : DTUAccelerometerData = data as! DTUAccelerometerData
                print("\(sensorType!.rawValue) ---- \(accelerometerData.acceleration!)")
                
//                let accelerometer = self.sensors[SensorType.Accelerometer.rawValue] as! Accelerometer
                let accelerometer = Accelerometer()
                accelerometer.id = SensorType.Accelerometer.rawValue
                accelerometer.date = NSDate()
                accelerometer.accelaration_x = (accelerometerData.acceleration?.x)!
                accelerometer.accelaration_y = (accelerometerData.acceleration?.y)!
                accelerometer.accelaration_z = (accelerometerData.acceleration?.z)!
                
                try! self.realm.write {
                    self.realm.add(accelerometer)
                }
                
            })
            senseKit.startContinuousSensingWithSensor(sensorType: .Accelerometer)
        }
    }
    
    func stopAccelerometerSensor() {
        senseKit.stopContinuousSensingWithSensor(sensor: .Accelerometer)
    }


    func activateGyroscopeSensor() {
        if senseKit.isSensorAvailable(sensor:.Gyroscope){
            let config : DTUGyroscopeConfiguration = DTUGyroscopeConfiguration()
            config.sampleRate = 5.0
            senseKit.registerSensor(sensor: .Gyroscope, withConfig: config)
            senseKit.subscribeToSensor(sensorType: .Gyroscope, handler: { (sensorType, data) in
                let gyroscopeData : DTUGyroscopeData = data as! DTUGyroscopeData
                print("\(sensorType!.rawValue) ---- \(gyroscopeData.rotationRate!)")
                
//                let gyroscope = self.sensors[SensorType.Gyroscope.rawValue] as! Gyroscope
                //Create sensor and add to study
                let gyroscope = Gyroscope()
                gyroscope.id = SensorType.Gyroscope.rawValue
                gyroscope.date = NSDate()
                gyroscope.rotation_x = (gyroscopeData.rotationRate?.x)!
                gyroscope.rotation_y = (gyroscopeData.rotationRate?.y)!
                gyroscope.rotation_z = (gyroscopeData.rotationRate?.z)!
                
                try! self.realm.write {
                    self.realm.add(gyroscope)
                }
            })
            senseKit.startContinuousSensingWithSensor(sensorType: .Gyroscope)
        }
    }
    
    func stopGyroscopeSensor() {
        senseKit.stopContinuousSensingWithSensor(sensor: .Gyroscope)
    }



}


extension StudyViewModel  {
    
    var text: String {
        if sensors["Accelerometer"]?.type == .Accelerometer {
            return "Accelerometer"
        }else if sensors["Gyroscope"]?.type == .Gyroscope {
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
        if sensors["Accelerometer"]?.type == .Accelerometer {
            if on {
                print("Accelerometer Active")
                activateAccelerometerSensor()
            } else {
                print("Accelerometer Inactive")
                stopAccelerometerSensor()
                
            }
        }else if sensors["Gyroscope"]?.type == .Gyroscope {
            if on {
                print("Gyroscope Active")
                activateGyroscopeSensor()
            } else {
                print("Gyroscope Inactive")
                stopGyroscopeSensor()
            }
        }
        
        
    }
}
