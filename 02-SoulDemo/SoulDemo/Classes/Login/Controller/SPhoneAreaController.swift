//
//  SPhoneAreaController.swift
//  SoulDemo
//
//  Created by study on 2019/4/11.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class SPhoneAreaController: UIViewController {

    private var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
}

// MARK:- 创建 UITableView 视图
extension SPhoneAreaController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier: String = "phoneAreaCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: indentifier)
            cell?.backgroundColor = UIColor.yellow
            cell?.selectionStyle = .none;
        }
        
        cell?.textLabel?.text = "index" + "\(indexPath.row)"
        
        return cell!
    }
}

// MARK:- 创建 UITableView 视图
extension SPhoneAreaController {
    private func setupTableView() {
        tableView = UITableView(frame:view.bounds, style:.plain)
        self.view.addSubview(tableView!)
        
        // 设置数据源和代理
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.lightGray
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        if #available(iOS 11.0, *) {
            
            var top_inset :CGFloat = 0
            if kScreenHeight == 812 {
                top_inset = 84
            } else {
                top_inset = 64 //  - 20
            }
            
            tableView?.contentInset = UIEdgeInsets(top: top_inset, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        }
        tableView?.scrollIndicatorInsets = (tableView?.contentInset)!
    }
}
