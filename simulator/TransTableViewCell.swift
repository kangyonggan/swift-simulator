//
//  TransTableViewCell.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit

class TransTableViewCell: UITableViewCell {
    
    // 控件
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func initData(_ item: (String, String, String)) {
        descLabel.text = item.0
        nameLabel.text = item.1
        valueLabel.text = item.2;
    }
    
}
