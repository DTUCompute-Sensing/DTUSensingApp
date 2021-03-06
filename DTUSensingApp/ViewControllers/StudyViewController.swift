//
//  StudyViewController.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit
import RealmSwift


enum StudySection : Int {
    case Motion
    case Health
    case Location
    case System
    case Count
    
    
    static var count = {
        return StudySection.Count.rawValue
    }
    
    static let sectionTitles = [
        Motion: "Motion",
        Health: "Health",
        Location: "Location",
        System : "System"
    ]
    
    func sectionTitle() -> String {
        if let sectionTitle = StudySection.sectionTitles[self] {
            return sectionTitle
        } else {
            return ""
        }
    }
}


enum CellIdentifiers:String {
    case switchWithTextCell
    case DetailLabelWithTitle
}


class StudyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailListSegue" {
            let vc = segue.destination as! DetailListViewController
            vc.sensor = sender as! Sensor?
        }
    }
}


extension StudyViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "detailListSegue", sender: )
        switch indexPath.row {
        case 0:
            let sensor = Accelerometer()
            sensor.type = .Accelerometer
            sensor.id = SensorType.Accelerometer.rawValue
            performSegue(withIdentifier: "detailListSegue", sender: sensor)
        case 1:
            let sensor = Sensor()
            sensor.type = .Gyroscope
            sensor.id = SensorType.Gyroscope.rawValue
            performSegue(withIdentifier: "detailListSegue", sender: sensor)
        case 2:
            let sensor = Sensor()
            sensor.type = .Magnetometer
            sensor.id = SensorType.Magnetometer.rawValue
            performSegue(withIdentifier: "detailListSegue", sender: sensor)
        default: break
            
        }
    }
}


extension StudyViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = StudySection(rawValue: section) else { return "" }
        return section.sectionTitle()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return StudySection.count()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = StudySection(rawValue: section) else { return 1 }
        
        switch section {
        case .Motion:
            return 3
        default: return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = StudySection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Motion:
            return cellForMotionSectionForRowAtIndexPath(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    

    private func cellForMotionSectionForRowAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.switchWithTextCell.rawValue, for: indexPath) as? SwitchWithTextTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            let sensor = Accelerometer()
            sensor.type = .Accelerometer
            sensor.id = SensorType.Accelerometer.rawValue
            let studyViewModel = StudyViewModel(withSensor: sensor)
            cell.configure(withPresenter: studyViewModel)
        case 1:
            let sensor = Sensor()
            sensor.type = .Gyroscope
            sensor.id = SensorType.Gyroscope.rawValue
            let studyViewModel = StudyViewModel(withSensor: sensor)
            cell.configure(withPresenter: studyViewModel)
        case 2:
            let sensor = Sensor()
            sensor.type = .Magnetometer
            sensor.id = SensorType.Magnetometer.rawValue
            let studyViewModel = StudyViewModel(withSensor: sensor)
            cell.configure(withPresenter: studyViewModel)
        default: break
            
        }
        return cell
    }
    
}



