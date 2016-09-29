//
//  DetailListViewController.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/27/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit
import RealmSwift

class DetailListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sensor : Sensor? = nil
    var sensorViewModel : SensorViewModel? = nil
    var notificationToken: NotificationToken? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        sensorViewModel = SensorViewModel(withSensor: sensor!)
        update()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopUpdate()
    }
    
    
    private func update() {
        let realm = try! Realm()
        
        switch sensor!.type! {
        case .Accelerometer :
           let results = realm.objects(Accelerometer.self)
           addNotificationToAccelerometer(result: results)
        case .Gyroscope :
           let results = realm.objects(Gyroscope.self)
            addNotificationToGyroscope(result: results)
        default:break
        }
    }
    
    private func addNotificationToAccelerometer(result : Results<Accelerometer>){
        notificationToken = result.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                //tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    private func addNotificationToGyroscope(result : Results<Gyroscope>){
        notificationToken = result.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                //tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }

    private func stopUpdate() {
        notificationToken?.stop()
    }
    
}



extension DetailListViewController : UITableViewDelegate {
    
}


extension DetailListViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sensorViewModel?.getObjectCount())!
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        return cellForDetailListForRowAtIndexPath(indexPath: indexPath)

    }
    
    private func cellForDetailListForRowAtIndexPath(indexPath : IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.DetailLabelWithTitle.rawValue, for: indexPath) as? DetailLabelWithTitleTableViewCell else {
            return UITableViewCell()
        }
        
        sensorViewModel?.index = indexPath.row
        cell.configure(withTitlePresenter: sensorViewModel!)
        return cell
    }
    

}
