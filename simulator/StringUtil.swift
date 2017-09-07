//
//  StringUtil.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class StringUtil: NSObject {
    
    // 去除首尾的空格和回车
    static func trim(_ str: String) -> String {
        return str.trimmingCharacters(in: .whitespacesAndNewlines);
    }
    
}
