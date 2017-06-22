//
//  ShowedTableController.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

typealias DateViewModel = HasDate & ModelType
let cellReusedID = "ShowedTableViewCell"

class ShowedTableController: UITableViewController {

    var dataList = [DateViewModel]()
    var loadeddataList:[DateViewModel] = [Event(date: "2月14", eventTitle: "送礼物"),Festival(date: "1月1日", festivalName: "元旦"),Festival(date: "2月14", festivalName: "情人节")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let delayInSeconds = 2.0
        let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {  () -> Void in
            
            /*
             注意这里，我故意把 loadeddataList 中的数据打乱了，
             为了实现异构数据的按照某个公共类型的属性的排序，
             使用了Swift内置的sort函数，String遵守了Compareable协议，
             这里为了简单把 date 指定为 String 类型,
             如果是 NSDate ，你可以在 sort 的闭包中指定合适的排序规则。
             */
           // self.dataList = self.loadeddataList.sorted(by: $0.date < $1.date)
            
            self.dataList = self.loadeddataList.sorted{$0.date < $1.date}
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReusedID, for: indexPath) as! ShowedableViewCell

        //注意这里，通过可选绑定进行异构数据的类型控制
        dataList[indexPath.row].giveData(view: cell)
        
        return cell
    }
}
