//
//  Bank.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class Bank: NSObject {
    
    override init() {
        
    }
    
    init(_ dict: NSDictionary) {
        self.bankCode = dict["code"] as? String;
        self.bankNo = dict["bankNo"] as? String;
        self.bankName = dict["bankName"] as? String;
    }
    
    // 银行代码，如：cmbc
    var bankCode: String!;

    // 银行编号，如：027
    var bankNo: String!;
    
    // 银行名称，如：民生超网
    var bankName: String!;
    
}
