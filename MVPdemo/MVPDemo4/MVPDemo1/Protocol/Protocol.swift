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

protocol CellPresentable {
    var mixLabelData: String { get set }
    var dateLabelData: String { get set }
    var color: UIColor { get set }
    func updateCell(cell:ShowedableViewCell)
}

extension CellPresentable {
    func updateCell(cell:ShowedableViewCell){
        cell.MixLabel.text = mixLabelData
        cell.dateLabel.text = dateLabelData
        cell.backgroundColor = color
    }
}

struct ViewModel: CellPresentable {
    
    var dateLabelData = ""
    var mixLabelData = ""
    var color = UIColor.white
    
    init(modal: Event) {
        self.dateLabelData = modal.date
        self.mixLabelData = modal.eventTitle
        self.color = UIColor.red
    }
    
    init(modal: Festival) {
        self.dateLabelData = modal.date
        self.mixLabelData = modal.festivalName
        self.color = UIColor.white
    }
}

/// 视图使用的协议
protocol RenderContext {
    func renderText(texts:String...)
    func renderImage(images:UIImage...)
}

/// 数据使用的协议
protocol ViewModelType {
    // 使用协议作为参数的类型
//    func renderInContext(context:RenderContext)
    // 使用协议作为泛型的约束条件
    func renderInContext<R:RenderContext>(context:R)
}

extension RenderContext {
    func renderText(texts:String...) {
        
    }

    func renderImage(images:UIImage...) {
        
    }
}
