//
//  DateUtil.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class DateUtil: NSObject {
    
    // 转为时间串
    static func toDateString(_ timestamp: Int64) -> String {
        let timeInterval:TimeInterval = TimeInterval(timestamp / 1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return format(date);
    }
    
    // 时间格式化
    static func format(_ date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format.string(from: date);
    }
    
    // 时间格式化
    static func format8(_ date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        return format.string(from: date);
    }
    
    // 日期解析
    static func parse8(_ str: String) -> Date {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        return format.date(from: str)!;
    }
    
}
