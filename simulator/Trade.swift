//
//  Trade.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class Trade: NSObject {
    
    override init() {
        
    }
    
    init(_ dict: NSDictionary) {
        self.label = dict["label"] as? String;
        self.name = dict["name"] as? String;
        self.key = dict["key"] as? String;
        self.value = dict["value"] as? String;
    }
    
    // 用于显示
    var label: String!;
    
    // 表单提交对应的name
    var name: String!;
    
    // 当前配置的key
    var key: String?;
    
    // 当前配置的value
    var value: String?;
    
}
