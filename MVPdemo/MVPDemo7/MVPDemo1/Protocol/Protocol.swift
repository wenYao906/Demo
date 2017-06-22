//
//  HasDate.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

protocol HasDate {
    var date: String { get }
}

/// 视图使用的协议
protocol ViewType {
    func getData<M: ModelType>(model: M)
}

/// 数据使用的协议
protocol ModelType {
    
}

/// 定义默认方法 giveData
extension ModelType {
    func giveData<V: ViewType>(view: V) {
        view.getData(model: self)
    }
}


protocol SharedString {
    
}

extension SharedString {
    func methodForOverride() {
        print("(｡•ˇ‸ˇ•｡)")
    }
    
    func methodWithoutOverride(){
        print("------------")
        
        methodForOverride()
        
        print("------------")
    }
}
