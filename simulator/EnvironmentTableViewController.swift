//
//  EnvironmentController.swift
//  simulator
//
//  Created by kangyonggan on 9/7/17.
//  Copyright © 2017 kangyonggan. All rights reserved.
//

import UIKit

class EnvironmentTableViewController: UITableViewController {
    
    let CELL_ID = "EnvironmentTableViewCell";
    
    // 所有环境
    var environments: [String]!;
    
    // 当前环境
    var currentEnvironment: String!;
    
    override func viewDidLoad() {
        currentEnvironment = FileUtil.currentEnvironment;
        environments = FileUtil.environments;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 导航条标题
        parent?.navigationItem.title = "环境切换";
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewEnvironment(_:)))
        parent?.navigationItem.rightBarButtonItem = addButton
    }
    
    // 新增环境
    func insertNewEnvironment(_ sender: Any) {
        let alertController = UIAlertController(title: "新增环境", message: "请输入新环境的地址", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "例如:https://kangyonggan.com/"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "提交", style: .default, handler: {
            action in
            let env = alertController.textFields!.first!.text;
            
            if StringUtil.trim(env!).isEmpty {
                Toast.showMessage("不能添加空地址", onView: self.view);
                return;
            }
            
            // 写入文件配置
            FileUtil.insertEnvironment(env!);
            
            self.environments.append(env!);
            self.tableView.reloadData();
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return environments.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! EnvironmentTableViewCell;
        
        cell.initData(environments[indexPath.row], isSelected: environments[indexPath.row] == currentEnvironment);
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentEnvironment == environments[indexPath.row] {
            return;
        }
        
        currentEnvironment = environments[indexPath.row];
        UrlConstants.DOMAIN = currentEnvironment;
        
        // 写入文件
        FileUtil.updateCurrentEnvironment(currentEnvironment);
        
        self.tableView.reloadData();
        
        Toast.showMessage("环境切换成功！", onView: self.view);
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteEnv = environments[indexPath.row];
            if deleteEnv == currentEnvironment {
                Toast.showMessage("不能删除当前正在使用的环境", onView: self.view);
                return
            }
            environments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 删除配置中的环境
            FileUtil.deleteEnvironment(deleteEnv);
        }
    }
    
    
}
