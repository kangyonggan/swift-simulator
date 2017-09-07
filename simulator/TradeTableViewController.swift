//
//  TradeTableViewController.swift
//  simulator
//
//  Created by kangyonggan on 9/6/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit
import Just

class TradeTableViewController: UITableViewController {
    
    var bank: Bank!;
    let CELL_ID = "TradeTableViewCell";
    var loadingView: UIActivityIndicatorView!;
    
    var trades = [Trade]();
    
    func initBank(_ bank: Bank) {
        self.bank = bank;
    }
    
    override func viewDidLoad() {
        // 导航条标题
        self.navigationItem.title = bank.bankName;
        // 返回按钮标题
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: nil, action: nil)
        
        // 添加刷新
        self.tableView.refreshControl = UIRefreshControl();
        self.tableView.refreshControl?.tintColor = AppConstants.MASTER_COLOR;
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingView = ViewUtil.loadingView(self.view);
        refreshData();
    }
    
    // 刷新数据
    func refreshData() {
        // 异步请求
        Http.post(UrlConstants.TRADE_LIST, params: ["bankCode": bank.bankCode], callback: tradeListCallback);
    }
    
    // 请求交易列表的回调
    func tradeListCallback(res: HTTPResult) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
        
        if loadingView != nil {
            ViewUtil.stopLoading(loadingView);
        }
        
        let result = Http.parse(res);
        
        if result.0 {
            self.trades = [];
            let data = result.2["trades"] as! NSArray;
            for d in data {
                let dict = d as! NSDictionary
                let trade = Trade(dict);
                
                self.trades.append(trade);
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
        return trades.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! TradeTableViewCell;
        
        cell.initData(trades[indexPath.row]);
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trade = trades[indexPath.row];
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfigTableViewController") as! ConfigTableViewController;
        vc.initInfo(bank, trade: trade);
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
}
