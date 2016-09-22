//
//  SwitchWithTextTableViewCell.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/21/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit



//protocol SensorPresentable {
//    var sensorType : SensorType {get}
//    
//    func activateSensor(activate : Bool)
//}

protocol TextPresentable {
    var text: String { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
}

protocol SwitchPresentable {
    var switchOn: Bool { get }
    var switchColor: UIColor { get }
    
    func onSwitchToggleOn(on: Bool)
}



typealias SwitchWithTextViewPresentable = TextPresentable & SwitchPresentable

class SwitchWithTextTableViewCell : UITableViewCell {

    @IBOutlet weak var switchToggle: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    private var delegate: SwitchWithTextViewPresentable?


    func configure(withPresenter presenter : SwitchWithTextViewPresentable) {
            delegate = presenter
        
        label.text = presenter.text
        switchToggle.isOn = presenter.switchOn
        switchToggle.onTintColor = presenter.switchColor
    }

    
    @IBAction func onSwitchToggle(_ sender: UISwitch) {
        delegate?.onSwitchToggleOn(on: sender.isOn)
    
    }
    
    
}


