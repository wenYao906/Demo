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

extension ShowedableViewCell {
    func updateWithPresenter(presenter:CellPresentable) {
        presenter.updateCell(cell: self)
    }
}
