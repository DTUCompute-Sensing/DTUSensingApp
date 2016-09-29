//
//  DetailLabelWithTitleTableViewCell.swift
//  DTUSensingApp
//
//  Created by Trevon Fernando on 9/23/16.
//  Copyright © 2016 DTU. All rights reserved.
//

import UIKit


typealias DetailLabelWithTitlePresentable = TextPresentable & DetailTextPresentable




protocol DetailTextPresentable {
    var detailText: String { get }
    var detailTextColor: UIColor { get }
    var detailFont: UIFont { get }
}


class DetailLabelWithTitleTableViewCell: UITableViewCell {

    func configure(withTitlePresenter presenter : DetailLabelWithTitlePresentable) {
        
        detailTextLabel?.text = presenter.detailText
        textLabel?.text = presenter.text
    }
    
}
