//
//  ConfigTableViewController.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit
import Just

class ConfigTableViewController: UITableViewController {
    
    var bank: Bank!;
    var trade: Trade!;
    let CELL_ID = "ConfigTableViewCell";
    var loadingView: UIActivityIndicatorView!;
    var configs = [Config]();
    
    func initInfo(_ bank: Bank, trade: Trade) {
        self.bank = bank;
        self.trade = trade;
    }
    
    override func viewDidLoad() {
        // 导航条标题
        self.navigationItem.title = bank.bankName + " - " + trade.label;
        
        // 添加刷新
        self.tableView.refreshControl = UIRefreshControl();
        self.tableView.refreshControl?.tintColor = AppConstants.MASTER_COLOR;
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        
        loadingView = ViewUtil.loadingView(self.view);
        refreshData();
    }
    
    // 刷新数据
    func refreshData() {
        // 异步请求
        Http.post(UrlConstants.CONFIG_LIST, params: ["bankCode": bank.bankCode, "key": trade.name], callback: configListCallback);
        
    }
    
    // 请求交易配置列表的回调
    func configListCallback(res: HTTPResult) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
        
        if loadingView != nil {
            ViewUtil.stopLoading(loadingView);
        }
        
        let result = Http.parse(res);
        
        if result.0 {
            let data = result.2["configs"] as! NSArray;
            
            // 不强制改变
            let cfg = Config();
            cfg.key = "默认";
            cfg.value = "不强制改变";
            self.configs.append(cfg);
            
            for d in data {
                let dict = d as! NSDictionary
                let config = Config(dict);
                
                self.configs.append(config);
            }
            
            // 在主线程中重新加载数据
            DispatchQueue.main.async {
                self.tableView.reloadData();
                self.jumpToRow();
            }
        } else {
            Toast.showMessage(result.1, onView: self.view);
        }
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configs.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! ConfigTableViewCell;
        
        cell.initData(configs[indexPath.row], isSelected: isSelected(indexPath.row));
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ViewUtil.isLoading(loadingView) {
            return;
        }
        
        loadingView = ViewUtil.loadingView(self.view);
        
        let config = configs[indexPath.row];
        
        // 异步请求
        Http.post(UrlConstants.CONFIG_UPDATE, params: ["bankCode": bank.bankCode, "type": trade.name, "key": config.key, "value": config.value], callback: configUpdateListCallback);
    }
    
    // 更新配置的回调
    func configUpdateListCallback(res: HTTPResult) {
        ViewUtil.stopLoading(loadingView);
        
        let result = Http.parse(res);
        
        if result.0 {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true);
            }
        } else {
            Toast.showMessage(result.1, onView: self.view);
        }
        
    }
    
    // 跳到当前选择的cell
    func jumpToRow() {
        // 跳转到当前的cell
        let row = self.clacRowIndex();
        let indexPath = IndexPath(row: row, section: 0);
        self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true);
    }
    
    // 计算当前行的下标
    func clacRowIndex() -> Int {
        if trade.key == nil {
            return 0;
        }
        
        var index = 0;
        for config in self.configs {
            if trade.key == config.key {
                return index;
            }
            index += 1;
        }
        
        return 0;
    }
    
    // 判断是否是选中的
    func isSelected(_ row: Int) -> Bool {
        if trade.key == nil {
            if row == 0 {
                return true;
            }
        } else {
            if trade.key == configs[row].key {
                return true;
            }
        }
        return false;
    }
    
}
