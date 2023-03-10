//
//  SwfitBaseController.swift
//  Demo
//
//  Created by study on 2023/3/10.
//

import UIKit

class SwfitBaseController : UITableViewController {
    
    let baseContentModel = [
        BaseContentModel(id: "1", title: "创建UITableViewController教程", url: "https://www.ralfebert.com/ios-examples/uikit/uitableviewcontroller/"),
        BaseContentModel(id: "2", title: "didSet")
    ]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseContentModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseCell", for: indexPath)
    
        let baseModel = baseContentModel[indexPath.row]
        cell.textLabel?.text = baseModel.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = BaseWebViewController()
        let baseModel = baseContentModel[indexPath.row]
        if let urlString = baseModel.url {
            webVC.urlString = urlString
        }
        
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section \(section)"
    }
}

struct BaseContentModel {
    var id: String
    var title: String
    var url:String?
}
