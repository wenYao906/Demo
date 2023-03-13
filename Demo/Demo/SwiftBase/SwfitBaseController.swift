//
//  SwfitBaseController.swift
//  Demo
//
//  Created by study on 2023/3/10.
//

import UIKit

class SwfitBaseController : UITableViewController {
    
//    let baseContentModel = [
//        let model = BaseListModel()
//    model.
////        BaseListModel(id: "1", title: "创建UITableViewController教程", url: "https://www.ralfebert.com/ios-examples/uikit/uitableviewcontroller/"),
////        BaseListModel(id: "2", title: "didSet"),
////        BaseListModel(id: "3", title: "创建WKWebView教程", url: "https://blog.csdn.net/sufubo/article/details/103123181"),
//    ]
    
//    private lazy var aModel: BaseListModel = {
//        let json = parseJSON()
//       let model = json
//        print("model ====== \(json)")
//
//        return model
//    }()
    
    override func viewDidLoad() {
        let json = parseJSON()
        print("json ====== \(json)")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3  //BaseListModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseCell", for: indexPath)
    
//        let baseModel = BaseListModel[indexPath.row]
        cell.textLabel?.text =  "123"//baseModel.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = BaseWebViewController()
//        let baseModel = BaseListModel[indexPath.row]
//        if let urlString = "http://www.baidu.com" { // baseModel.url
//            webVC.urlString = urlString
            webVC.urlString = "http://www.baidu.com"
//        }
        
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section \(section)"
    }
    
    private func parseJSON() {
        // BaseJson.json 需要添加到 Copy Bundle Resource
        guard let path = Bundle.main.path(forResource: "BaseJson", ofType: "json") else {
            print("\n-------> bundle path error")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(BaseListModel.self, from: jsonData)
            print("\n-------> response: \(response)")
        }
        catch {
            print("\n====> error: \(error)" )
        }
        return
    }

}


