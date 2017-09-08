//
//  TradeQueryController.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit
import Just

class TransQueryController: UIViewController {
    
    // 控件
    @IBOutlet weak var serialNoInput: UITextField!
    
    var loadingView: UIActivityIndicatorView!;
    
    override func viewDidLoad() {
        // 返回按钮标题
        parent?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 导航条标题
        parent?.navigationItem.title = "查询交易";
        parent?.navigationItem.rightBarButtonItem = nil
    }
    
    // 查询
    @IBAction func query(_ sender: Any) {
        // 收起键盘
        UIApplication.shared.keyWindow?.endEditing(true);
        
        if ViewUtil.isLoading(loadingView) {
            return;
        }
        
        let serialNo = StringUtil.trim(serialNoInput.text!);
        
        if serialNo.characters.count != 16 {
            Toast.showMessage("请输入16位的be流水号", onView: self.view);
            return;
        }
        
        loadingView = ViewUtil.loadingView(self.view);
        
        // 异步查询
        Http.post(UrlConstants.TRANS_QUERY, params: ["serialNo": serialNo], callback: queryCallback)
    }
    
    // 查询回调
    func queryCallback(res: HTTPResult) {
        ViewUtil.stopLoading(loadingView);
        
        let result = Http.parse(res);
        
        if result.0 {
            let data = result.2["trans"] as! NSDictionary;
            let trans = Trans(data);

            DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransTableViewController") as! TransTableViewController;
                vc.initTrans(trans);
                self.navigationController?.pushViewController(vc, animated: true);
            }
        } else {
            Toast.showMessage(result.1, onView: self.view);
        }
    }
}
