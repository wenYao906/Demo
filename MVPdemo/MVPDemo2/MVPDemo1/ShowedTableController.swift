//
//  ShowedTableController.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

let cellReusedID = "ShowedTableViewCell"
class ShowedTableController: UITableViewController {

    var dataList = [HasDate]()
    var loadeddataList:[HasDate] = [Event(date: "2月14", title: "送礼物"),Festival(date: "1月1日", name: "元旦"),Festival(date: "2月14", name: "情人节")]
    
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
        
        if let event = dataList[indexPath.row] as? Event {
            cell.MixLabel.text = event.eventTitle
            cell.dateLabel.text = event.date
            cell.backgroundColor = UIColor.red
            return cell
        }else if let festival = dataList[indexPath.row] as? Festival {
            cell.MixLabel.text = festival.festivalName
            cell.dateLabel.text = festival.date
            cell.backgroundColor = UIColor.white
        }else {
            return cell
        }

        return cell
    }
}
