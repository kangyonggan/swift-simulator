//
//  Config.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class Config: NSObject {
    
    override init() {
        
    }
    
    init(_ dict: NSDictionary) {
        self.key = dict["k"] as? String;
        self.value = dict["val"] as? String;
    }
    
    // 响应码
    var key: String!;
    
    // 响应描述
    var value: String!;
    
}
