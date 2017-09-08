//
//  TransQueryResultController.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit
import Just

class TransTableViewController: UITableViewController {
    
    let CELL_ID = "TransTableViewCell";
    var trans: Trans!;
    var items = [(String, String, String)]();
    var loadingView: UIActivityIndicatorView!;
    
    var tmpWorkDay = "";
    var item: (String, String, String)!;
    
    func initTrans(_ trans: Trans) {
        self.trans = trans;
        
        items.append(("流水号", "serialNo", trans.serialNo));
        items.append(("银行编号", "bankNo", trans.bankNo));
        items.append(("账号", "accoNo", trans.accoNo));
        items.append(("交易类型", "transType", trans.transType));
        items.append(("金额", "amount", trans.amount));
        items.append(("响应码", "respCode", trans.respCode));
        items.append(("交易状态", "transStat", trans.transStat));
        items.append(("内部状态", "stat", trans.stat));
        items.append(("工作日", "workDay", trans.workDay ?? ""));
        items.append(("协议号", "protocolNo", trans.protocolNo ?? ""));
        items.append(("交易时间", "createdTime", DateUtil.toDateString(trans.createdTime)));
        items.append(("更新时间", "updatedTime", DateUtil.toDateString(trans.updatedTime)));
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! TransTableViewCell;
        
        cell.initData(items[indexPath.row]);
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        item = items[indexPath.row];
        
        let name = item.1;
        // 这些字段不给修改
        if name == "serialNo" || name == "createdTime" || name == "updatedTime" {
            return;
        }
        
        // 日期选择
        if name == "workDay" {
            updateWorkDay();
            return;
        }
        
        // 更新交易
        updateTrans();
        
    }
    
    // 更新交易
    func updateTrans() {
        let alertController = UIAlertController(title: "修改\(self.item.0)", message: nil, preferredStyle: .alert)
        alertController.addTextField {(textField: UITextField!) -> Void in
            textField.placeholder = "请输入修改后的\(self.item.0)"
            textField.text = self.item.2
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "提交", style: .default, handler: {
            action in
            let val = StringUtil.trim(alertController.textFields!.first!.text!);
            
            if ViewUtil.isLoading(self.loadingView) {
                return;
            }
            
            self.item.2 = val;
            
            self.loadingView = ViewUtil.loadingView(self.view);
            
            // 异步更新数据
            Http.post(UrlConstants.TRANS_UPDATE, params: ["id": self.trans.id, self.item.1: val], callback: self.updateTransDayCallback)
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 更新交易信息的回调
    func updateTransDayCallback(res: HTTPResult) {
        ViewUtil.stopLoading(loadingView);
        
        let result = Http.parse(res);
        
        if result.0 {
            DispatchQueue.main.async {
                for i in 0..<self.items.count {
                    if self.items[i].1 == self.item.1 {
                        self.items[i].2 = self.item.2;
                        break;
                    }
                }
                self.tableView.reloadData();
            }
            
            Toast.showMessage("交易信息修改成功", onView: self.view);
        } else {
            
            Toast.showMessage(result.1, onView: self.view);
        }
    }
    
    // 更新工作日
    func updateWorkDay() {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker( )
        datePicker.locale = Locale(identifier: "zh_CN");
        datePicker.datePickerMode = .date
        if trans.workDay != nil {
            datePicker.date = DateUtil.parse8(trans.workDay!);
        } else {
            datePicker.date = Date();
        }
        alertController.addAction(UIAlertAction(title: "确定", style: .default) {(alertAction) -> Void in
            
            if ViewUtil.isLoading(self.loadingView) {
                return;
            }
            
            self.loadingView = ViewUtil.loadingView(self.view);
            
            self.tmpWorkDay = DateUtil.format8(datePicker.date);
            
            // 异步更新数据
            Http.post(UrlConstants.TRANS_UPDATE, params: ["id": self.trans.id, "workDay": self.tmpWorkDay], callback: self.updateWorkDayCallback)
            
        })
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel,handler:nil))
        alertController.view.addSubview(datePicker)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 更新工作日的回调
    func updateWorkDayCallback(res: HTTPResult) {
        ViewUtil.stopLoading(loadingView);
        
        let result = Http.parse(res);
        
        if result.0 {
            DispatchQueue.main.async {
                self.items[8].2 = self.tmpWorkDay;
                self.tableView.reloadData();
            }
            
            Toast.showMessage("交易信息修改成功", onView: self.view);
        } else {
            
            Toast.showMessage(result.1, onView: self.view);
        }
    }
    
}
