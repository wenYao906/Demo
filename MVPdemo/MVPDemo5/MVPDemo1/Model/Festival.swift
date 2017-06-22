//
//  Festival.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

struct Festival: HasDate,ModelType {

    var date = ""
    var festivalName = ""

    func giveData<V>(view: V) where V : ViewType {
        view.getData(model: self)
    }
}
