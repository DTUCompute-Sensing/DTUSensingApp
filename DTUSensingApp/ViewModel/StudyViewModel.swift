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
    
    //MARK : Accelerometer
    
    func activateAccelerometerSensor() {
        if senseKit.isSensorAvailable(sensor: .Accelerometer){
            let config : DTUAccelerometerConfiguration = DTUAccelerometerConfiguration()
            config.sampleRate = 5.0
            senseKit.registerSensor(sensor: .Accelerometer, withConfig: config)
            senseKit.subscribeToSensor(sensorType: .Accelerometer, handler: { (sensorType, data) in
                let accelerometerData : DTUAccelerometerData = data as! DTUAccelerometerData
                print("\(sensorType!.rawValue) ---- \(accelerometerData.acceleration!)")
                
                let accelerometer = Accelerometer()
                accelerometer.date = accelerometerData.timeStamp
                accelerometer.id = SensorType.Accelerometer.rawValue
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


    //MARK : Gyroscope

    func activateGyroscopeSensor() {
        if senseKit.isSensorAvailable(sensor:.Gyroscope){
            let config : DTUGyroscopeConfiguration = DTUGyroscopeConfiguration()
            config.sampleRate = 5.0
            senseKit.registerSensor(sensor: .Gyroscope, withConfig: config)
            senseKit.subscribeToSensor(sensorType: .Gyroscope, handler: { (sensorType, data) in
                let gyroscopeData : DTUGyroscopeData = data as! DTUGyroscopeData
                print("\(sensorType!.rawValue) ---- \(gyroscopeData.rotationRate!)")
                
                let gyroscope = Gyroscope()
                gyroscope.date = gyroscopeData.timeStamp
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
    
    //MARK : Magnetometer

    
    func activateMagnetometerSensor() {
        if senseKit.isSensorAvailable(sensor:.Magnetometer){
            let config : DTUMagnetometerConfiguration = DTUMagnetometerConfiguration()
            config.sampleRate = 5.0
            senseKit.registerSensor(sensor: .Magnetometer, withConfig: config)
            senseKit.subscribeToSensor(sensorType: .Magnetometer, handler: { (sensorType, data) in
                let magnetometerData : DTUMagnetometerData = data as! DTUMagnetometerData
                print("\(sensorType!.rawValue) ---- \(magnetometerData.magneticField!)")
                
                let magnetometer = Magnetometer()
                magnetometer.date = magnetometerData.timeStamp
                magnetometer.id = SensorType.Magnetometer.rawValue
                magnetometer.date = NSDate()
                magnetometer.magnatic_x = (magnetometerData.magneticField?.x)!
                magnetometer.magnatic_y = (magnetometerData.magneticField?.y)!
                magnetometer.magnatic_z = (magnetometerData.magneticField?.z)!
                
                try! self.realm.write {
                    self.realm.add(magnetometer)
                }
            })
            senseKit.startContinuousSensingWithSensor(sensorType: .Magnetometer)
        }
    }
    
    func stopMagnetometerSensor() {
        senseKit.stopContinuousSensingWithSensor(sensor: .Magnetometer)
    }



}


extension StudyViewModel  {
    
    var text: String {
        if sensors["Accelerometer"]?.type == .Accelerometer {
            return "Accelerometer"
        }else if sensors["Gyroscope"]?.type == .Gyroscope {
            return "Gyroscope"
        }else if sensors["Magnetometer"]?.type == .Magnetometer {
            return "Magnetometer"
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
        }else if sensors["Magnetometer"]?.type == .Magnetometer {
            if on {
                print("Magnetometer Active")
                activateMagnetometerSensor()
            } else {
                print("Magnetometer Inactive")
                stopMagnetometerSensor()
            }
        }
    }
}
