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

        if senser.isSensorAvailable(sensor: .Accelerometer){
            senser.registerSensor(sensor: .Accelerometer)
            senser.subscribeToSensor(sensorType: .Accelerometer, handler: { (sensorType, data) in
                let accelerometerData : DTUAccelerometerData = data as! DTUAccelerometerData
                print("\(sensorType!.rawValue) ---- \(accelerometerData.acceleration!)")
            })
            
            senser.startContinuousSensingWithSensor(sensorType: .Accelerometer)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

