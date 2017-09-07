//
//  ConfigTableViewCell.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit

class ConfigTableViewCell: UITableViewCell {
    
    // 控件
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    
    // 初始化数据
    func initData(_ config: Config, isSelected: Bool) {
        keyLabel.text = config.key;
        valueLabel.text = config.value;
        
        if isSelected {
            leftImage.isHidden = false;
        } else {
            leftImage.isHidden = true;
            
        }
        let keyFrame = CGRect(x: self.frame.width - 135, y: 0, width: 120, height: self.frame.height)
        keyLabel.frame = keyFrame;
    }
    
}
