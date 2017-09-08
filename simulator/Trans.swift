//
//  Trans.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class Trans: NSObject {
    
    
    override init() {
        
    }
    
    init(_ dict: NSDictionary) {
        self.id = dict["id"] as? Int;
        self.serialNo = dict["beSer"] as? String;
        self.bankNo = dict["bankNo"] as? String;
        self.accoNo = dict["accoNo"] as? String;
        self.transType = dict["transType"] as? String;
        self.amount = dict["amount"] as? String;
        self.respCode = dict["respCode"] as? String;
        self.transStat = dict["transStat"] as? String;
        self.stat = dict["stat"] as? String;
        self.workDay = dict["workDay"] as? String;
        self.protocolNo = dict["protocolNo"] as? String;
        self.createdTime = dict["createdTime"] as? Int64;
        self.updatedTime = dict["updatedTime"] as? Int64;
    }
    
    var id: Int!;
    
    // be流水号
    var serialNo: String!;
    
    // 银行编码
    var bankNo: String!;
    
    var accoNo: String!;
    
    var transType: String!;
    
    var amount: String!;
    
    var respCode: String!;
    
    var transStat: String!;
    
    var stat: String!;
    
    var workDay: String?;
    
    var protocolNo: String?;
    
    var createdTime: Int64!;
    
    var updatedTime: Int64!;
}
