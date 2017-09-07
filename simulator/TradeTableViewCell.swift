//
//  TradeTableViewCell
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit

class TradeTableViewCell: UITableViewCell {
    
    // 控件
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var valueLbel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    // 初始化数据
    func initData(_ trade: Trade) {
        labelLabel.text = trade.label;
        typeLabel.text = trade.name;
        
        if trade.key != nil {
            valueLbel.text = trade.value;
            keyLabel.text = trade.key;
        } else {
            valueLbel.text = "不强制改变";
            keyLabel.text = "默认";
        }
        
        let keyFrame = CGRect(x: self.frame.width - 155, y: 30, width: 120, height: 20)
        keyLabel.frame = keyFrame;
        
        let valFrame = CGRect(x: self.frame.width - 155, y: 8, width: 120, height: 30)
        valueLbel.frame = valFrame;
    }
    
}
