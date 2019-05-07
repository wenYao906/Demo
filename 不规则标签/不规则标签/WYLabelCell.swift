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
    
    /// 必须写，用来自动计算行高
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let att = super.preferredLayoutAttributesFitting(layoutAttributes);
        
        let string = label.text!
        
        var newFram = string.autoLabelCGRect(with: 30, font: label.font)
        
        newFram.size.height += 10;
        newFram.size.width += 10;
        att.frame = newFram;

        
        // 如果你cell上的子控件不是用约束来创建的,那么这边必须也要去修改cell上控件的frame才行
        self.label.frame = CGRect(x: 0, y: 0, width: newFram.size.width, height: 30)
        
        return att;
    }
}

extension String {
    
    func autoLabelCGRect(with labelHeight: CGFloat, font: UIFont) -> CGRect {
        var size1 = CGRect()
        let size2 = CGSize(width: CGFloat(MAXFLOAT), height: labelHeight)//设置label的最大宽度
        size1 = self.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font] , context: nil);
        return size1
    }
}

