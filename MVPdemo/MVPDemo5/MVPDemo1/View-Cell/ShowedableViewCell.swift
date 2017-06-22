//
//  ShowedableViewCell.swift
//  MVPDemo1
//
//  Created by study on 2017/6/21.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

class ShowedableViewCell: UITableViewCell {

    //用来展示事件主题或节日名称的Label
    @IBOutlet weak var MixLabel: UILabel!
    //用来展示日期的Label
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ShowedableViewCell: ViewType {
    
    func getData<M>(model: M) where M : ModelType {
        //这里不能写成guard let dateModel = model as? DateViewModel else{}令我有些意外
        guard let dateModel = model as? HasDate else {
            // 不满足cell基本需求的model直接淘汰掉
            return
        }
        
        // 处理相同属性
        dateLabel.text = dateModel.date
        
        // 处理数据源异构
        if let event = dateModel as? Event {
            MixLabel.text = event.eventTitle
            backgroundColor = UIColor.red
        }else if let festival = dateModel as? Festival {
            MixLabel.text = festival.festivalName
            backgroundColor = UIColor.white
        }
    }
}
