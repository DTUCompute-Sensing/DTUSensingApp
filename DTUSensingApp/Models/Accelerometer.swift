//
//  Accelerometer.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import Foundation
import RealmSwift

class Accelerometer: Sensor {
    
    dynamic var accelaration_x : Double = 0.0
    dynamic var accelaration_y : Double = 0.0
    dynamic var accelaration_z : Double = 0.0


    public func generateCSV() -> Data{
        let realmm = try! Realm()
        let properties : [String] = ["date", "accelaration_x", "accelaration_y", "accelaration_z"]
        var valuesDic : [String : [String]] = [:]
        let values = realmm.objects(Accelerometer.self)
        
        //TODO : Create CSV , array can be generated from data
        for property in properties {
            var propertyValues : [String] = []
            for value in values {
                if property == "date" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyy hh:mm:ss zzz"
                    propertyValues.append(dateFormatter.string(from: value.date as! Date))
                }else{
                    propertyValues.append("\(value.value(forKey: property)!)")
                }
            }
            valuesDic[property] = propertyValues
        }
        
        var cvsString = properties.joined(separator: ",")

        for i in 0 ..< (valuesDic["date"]?.count)! {
            cvsString = cvsString + "\n"
            cvsString = cvsString + "\((valuesDic["date"]?[i])!),"
            cvsString = cvsString + "\((valuesDic["accelaration_x"]?[i])!),"
            cvsString = cvsString + "\((valuesDic["accelaration_y"]?[i])!),"
            cvsString = cvsString + "\((valuesDic["accelaration_z"]?[i])!)"
        }
        
        let cvsStringToData = cvsString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        return cvsStringToData!
    }
}
