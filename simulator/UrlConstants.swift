//
//  UrlConstants.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//


import Foundation

// 请求地址常量
class UrlConstants: NSObject {
    
    // 域名
    static var DOMAIN = "http://10.199.105.220:8080/";
//    static let DOMAIN = "http://127.0.0.1:8080/";
//    static let DOMAIN = "http://10.199.105.220:8080/";
    
    // 手机端前缀
    static let MOBILE = "mobile/";
    
    // 查询银行通道列表
    static let BANK_LIST = MOBILE + "bank/list";
    
    // 查询银行交易列表
    static let TRADE_LIST = MOBILE + "trade/list";
    
    // 查询交易配置列表
    static let CONFIG_LIST = MOBILE + "config/list";
    
    // 修改配置
    static let CONFIG_UPDATE = MOBILE + "config/update";
    
    // 交易查询
    static let TRANS_QUERY = MOBILE + "trans/query";
    
    // 更新交易
    static let TRANS_UPDATE = MOBILE + "trans/update";
}

