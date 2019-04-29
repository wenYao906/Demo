//
//  WYLabelCell.swift
//  不规则标签
//
//  Created by study on 2019/4/29.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class WYLabelCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        label.frame = frame
        label.text = "123123123123"
        label.backgroundColor = UIColor.red
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
