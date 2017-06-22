//
//  Festival.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

class Festival: NSObject {

    var date = ""
    var festivalName = ""
    init(date:String,name:String) {
        self.date = date
        self.festivalName = name
    }
}
