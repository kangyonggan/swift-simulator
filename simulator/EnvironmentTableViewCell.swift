//
//  EnvironmentTableViewCell.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit

class EnvironmentTableViewCell: UITableViewCell {
    
    // 控件
    @IBOutlet weak var envLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    
    // 初始化数据
    func initData(_ env: String, isSelected: Bool) {
        envLabel.text = env;
        if isSelected {
            leftImage.isHidden = false;
        } else {
            leftImage.isHidden = true;
        }
    }
    
}
