//
//  FileUtil.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import Foundation

class FileUtil: NSObject {
    
    // 全部环境配置文件名
    static let ENVIRONMENTS_FILE_NAME = "environments.cfg";
    // 当前环境配置文件名
    static let ENVIRONMENTS_CURRENT_FILE_NAME = "environments-current.cfg";
    
    // 所有环境
    static var environments = [String]();
    // 当前环境
    static var currentEnvironment: String!;
    
    // 初始化环境
    static func initEnvironment() {
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let environmentsFile = docPath.appendingPathComponent(ENVIRONMENTS_FILE_NAME)
        
        // 如果配置不存在，则初始化
        if !manager.fileExists(atPath: environmentsFile.path) {
            // 初始全部环境的配置
            environments.append("http://10.199.105.220:8080/");
            environments.append("https://kangyonggan.com/");
            // 初始当前环境的配置
            currentEnvironment = environments[0];
            
            // 创建文件
            manager.createFile(atPath: environmentsFile.path, contents: nil, attributes:nil)
            
            // 写入配置
            for env in environments {
                let appendedData = (env + "\n").data(using: String.Encoding.utf8, allowLossyConversion: true)
                let writeHandler = try? FileHandle(forWritingTo: environmentsFile)
                writeHandler!.seekToEndOfFile()
                writeHandler!.write(appendedData!)
            }
            
            // 初始化当前环境的配置
            let environmentsCurrentFile = docPath.appendingPathComponent(ENVIRONMENTS_CURRENT_FILE_NAME)
            // 创建文件
            manager.createFile(atPath: environmentsCurrentFile.path, contents: nil, attributes:nil)
            // 写入配置
            let appendedData = currentEnvironment.data(using: String.Encoding.utf8, allowLossyConversion: true)
            let writeHandler = try? FileHandle(forWritingTo: environmentsCurrentFile)
            writeHandler!.seekToEndOfFile()
            writeHandler!.write(appendedData!)
        } else {
            // 读取全部环境配置
            let data = manager.contents(atPath: environmentsFile.path)
            let allEnvs = String(data: data!, encoding: String.Encoding.utf8)
            
            for env in (allEnvs?.characters.split(separator: "\n"))! {
                environments.append(String(env));
            }
            
            // 读取当前环境配置
            let currentEnvironmentFile = docPath.appendingPathComponent(ENVIRONMENTS_CURRENT_FILE_NAME);
            let dataCurrent = manager.contents(atPath: currentEnvironmentFile.path)
            currentEnvironment = String(data: dataCurrent!, encoding: String.Encoding.utf8)
        }
        
    }
    
    // 更新当前环境配置
    static func updateCurrentEnvironment(_ env: String) {
        currentEnvironment = env;
        
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let currentEnvironmentFile = docPath.appendingPathComponent(ENVIRONMENTS_CURRENT_FILE_NAME);
        
        // 删除文件
        try! manager.removeItem(atPath: currentEnvironmentFile.path);
        
        // 创建文件
        manager.createFile(atPath: currentEnvironmentFile.path, contents: nil, attributes:nil)
        
        let appendedData = currentEnvironment.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let writeHandler = try? FileHandle(forWritingTo: currentEnvironmentFile)
        writeHandler!.seek(toFileOffset: 0);
        writeHandler!.write(appendedData!)
    }
    
    // 新增配置
    static func insertEnvironment(_ env: String) {
        environments.append(env);
        
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let environmentsFile = docPath.appendingPathComponent(ENVIRONMENTS_FILE_NAME)
        
        // 删除文件
        try! manager.removeItem(atPath: environmentsFile.path);
        
        // 创建文件
        manager.createFile(atPath: environmentsFile.path, contents: nil, attributes:nil)
        
        // 写入配置
        for env in environments {
            let appendedData = (env + "\n").data(using: String.Encoding.utf8, allowLossyConversion: true)
            let writeHandler = try? FileHandle(forWritingTo: environmentsFile)
            writeHandler!.seekToEndOfFile()
            writeHandler!.write(appendedData!)
        }
    }
    
    // 删除配置
    static func deleteEnvironment(_ env: String) {
        var index = 0;
        for e in environments {
            if e == env {
                break;
            }
            
            index += 1;
        }
        environments.remove(at: index);
        
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let environmentsFile = docPath.appendingPathComponent(ENVIRONMENTS_FILE_NAME);
        
        // 删除文件
        try! manager.removeItem(atPath: environmentsFile.path);
        
        // 创建文件
        manager.createFile(atPath: environmentsFile.path, contents: nil, attributes:nil)
        
        // 写入配置
        for env in environments {
            let appendedData = (env + "\n").data(using: String.Encoding.utf8, allowLossyConversion: true)
            let writeHandler = try? FileHandle(forWritingTo: environmentsFile)
            writeHandler!.seekToEndOfFile()
            writeHandler!.write(appendedData!)
        }
    }
    
    
}
