//
//  SwfitBaseController.swift
//  Demo
//
//  Created by study on 2023/3/10.
//

import UIKit

class SwfitBaseController : UITableViewController {

    private lazy var model: [BaseList_listModel] = {
        let json = parseJSON()
        let aModel = json
        return aModel!
    }()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseCell", for: indexPath)
    
        let aModel = self.model[indexPath.row]
        cell.textLabel?.text = aModel.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = BaseWebViewController()
        
        let aModel = self.model[indexPath.row]
        if let urlString = aModel.url {
            webVC.urlString = urlString
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section \(section)"
    }
    
    /// 获取json中的数据，并返回
    private func parseJSON() -> [BaseList_listModel]? {
        // BaseJson.json 需要添加到 Copy Bundle Resource
        guard let path = Bundle.main.path(forResource: "BaseJson", ofType: "json") else {
            print("\n-------> bundle path error")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let response:BaseListModel = try JSONDecoder().decode(BaseListModel.self, from: jsonData)
            
            print("\n-------> response: \(response)")
            return response.list
        }
        catch {
            print("\n====> error: \(error)" )
//            return error
        }
        return nil
    }

}


