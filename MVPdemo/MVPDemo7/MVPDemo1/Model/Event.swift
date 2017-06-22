//
//  Event.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

struct Event:HasDate, ModelType {
    var date = ""
    var eventTitle = ""
}


/* 可以写成
 
 struct Event {
     var date: String
     var eventTitle: String
     init(date:String = "", title:String = "") {
         self.date = date
         self.eventTitle = title
     }
 }

 
 */
