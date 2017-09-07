//
//  BankTableViewController.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit
import Just

class BankTableViewController: UITableViewController {
    
    let CELL_ID = "BankTableViewCell";
    
    //拉刷新控制器
    var banks = [Bank]();
    var loadingView: UIActivityIndicatorView!;
    
    override func viewDidLoad() {
        // 返回按钮标题
        parent?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: nil, action: nil)
    
        // 获取环境
        FileUtil.initEnvironment();
        UrlConstants.DOMAIN = FileUtil.currentEnvironment;
        
        // 添加刷新
        self.tableView.refreshControl = UIRefreshControl();
        self.tableView.refreshControl?.tintColor = AppConstants.MASTER_COLOR;
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        
        loadingView = ViewUtil.loadingView(self.view);
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 导航条标题
        parent?.navigationItem.title = "选择银行通道";
        parent?.navigationItem.rightBarButtonItem = nil
    }
    
    // 刷新数据
    func refreshData() {
        // 异步请求
        Http.post(UrlConstants.BANK_LIST, callback: bankListCallback);
    }
    
    // 请求通道列表的回调
    func bankListCallback(res: HTTPResult) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
        
        if loadingView != nil {
            ViewUtil.stopLoading(loadingView);
        }
        
        let result = Http.parse(res);
        
        if result.0 {
            self.banks = [];
            let data = result.2["banks"] as! NSArray;
            for d in data {
                let dict = d as! NSDictionary
                let bank = Bank(dict);
                
                // 倒叙
                self.banks.insert(bank, at: 0);
            }
            
            // 在主线程中重新加载数据
            DispatchQueue.main.async {
                self.tableView.reloadData();
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
        return banks.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! BankTableViewCell;
        
        cell.initData(banks[indexPath.row]);
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = banks[indexPath.row];
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TradeTableViewController") as! TradeTableViewController;
        vc.initBank(bank);
        self.navigationController?.pushViewController(vc, animated: true);
        
    }
    
}
