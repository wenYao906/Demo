//
//  BaseModel.swift
//  Demo
//
//  Created by study on 2023/3/13.
//

import Foundation
import UIKit

struct BaseListModel: Codable {
    let list: [BaseList_listModel]
}

struct BaseList_listModel: Codable {
    var id: String
    var title: String
    var url: String?
    //    var list:[TableViewItem]?
   
}

struct TableViewItem {
    var id: Int
    var title: String
}


