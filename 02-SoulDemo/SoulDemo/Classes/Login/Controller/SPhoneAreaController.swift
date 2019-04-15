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
    var dataPlist: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        dataPlist = SPlistTool.plistWithAreaCode()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 显示导航栏
        self.navigationController?.navigationBar.isHidden = false
    }
}

// MARK:- 创建 UITableView 视图
extension SPhoneAreaController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPlist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier: String = "phoneAreaCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: indentifier)
            cell?.backgroundColor = UIColor.yellow
            cell?.selectionStyle = .none;
        }
        
        /// 每个国家
        let aCountry = dataPlist?[indexPath.row] as! NSArray
        /// 国家的名字
        let countryName = aCountry[0] as! String
        /// 国家的区号
        let countryAreaNo = aCountry[1]  as! String
        
        cell?.textLabel?.text = countryName
        cell?.detailTextLabel?.text = countryAreaNo
        
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
        
        tableView?.scrollIndicatorInsets = (tableView?.contentInset)!
    }
}
