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

    var eventList = [Event]()
    var festivalList = [Festival]()
    let loadedEventList = [Event(date: "2月14", title: "送礼物")]
    let loadedFestivalList = [Festival(date: "1月1日", name: "元旦"),
                              Festival(date: "2月14", name: "情人节")
                              ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let delayInSeconds = 2.0
        let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) { 
            self.eventList = self.loadedEventList
            self.festivalList = self.loadedFestivalList
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
        return eventList.count + festivalList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReusedID, for: indexPath) as! ShowedableViewCell

        /*
         传统的mvc,你需要在这里处理数据本身的同构与异构情况，还得处理数据与视图的逻辑关系
         这里我们把时间提醒放在节日的前面展示
         */
        
        if indexPath.row > eventList.count - 1 {
            cell.MixLabel.text = festivalList[indexPath.row - eventList.count].festivalName
            cell.dateLabel.text = festivalList[indexPath.row - eventList.count].date
            cell.backgroundColor = UIColor.white
        }else {
            cell.MixLabel.text = eventList[indexPath.row].eventTitle
            cell.dateLabel.text = eventList[indexPath.row].date
            cell.backgroundColor = UIColor.red
        }

        return cell
    }
}
