//
//  Festival.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

struct Festival: HasDate,ViewModelType {

    var date = ""
    var festivalName = ""
//    init(date:String,name:String) {
//        self.date = date
//        self.festivalName = name
//    }
    
    func renderInContext<R>(context: R) where R : RenderContext {
        context.renderText(texts: date,festivalName)
    }
}
