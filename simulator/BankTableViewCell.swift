//
//  BankTableViewCell.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {
    
    // 控件
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankInfoLabel: UILabel!
    
    // 初始化数据
    func initData(_ bank: Bank) {
        bankNameLabel.text = bank.bankName;
        bankInfoLabel.text = bank.bankCode + "/" + bank.bankNo
    }
    
    
}
