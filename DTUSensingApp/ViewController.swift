//
//  ViewController.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/16/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit
import DTUSenseCore


class ViewController: UIViewController {

    let senser = DTUSenceKit.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if senser.isSensorAvailable(sensor: .Accelerometer){
//            let accConfig : DTUGyroscopeConfiguration = DTUGyroscopeConfiguration()
//            accConfig.sampleRate = 5.0
//            senser.registerSensor(sensor: .Gyroscope, withConfig: accConfig)
//            senser.subscribeToSensor(sensorType: .Gyroscope, handler: { (sensorType, data) in
//                let gyroData : DTUGyroscopeData = data as! DTUGyroscopeData
//                print("\(sensorType!.rawValue) ---- \(gyroData.rotationRate!)")
//            })
//            senser.startContinuousSensingWithSensor(sensorType: .Gyroscope)
//        }
        
    }
}

