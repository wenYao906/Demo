//
//  SLoginTopicView.swift
//  SoulDemo
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 登录界面等的上半部分  APP名称和副标题
class SLoginTopicView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- app名称
extension SLoginTopicView {
    // 上: 图片（上）， 文本标签 （下）
    private func setupHeaderView() {
        let aIW: CGFloat = 100
        let aIH: CGFloat = 50
        let aIX: CGFloat = (kScreenWidth - aIW) * 0.5
        let aIY: CGFloat = 0
        let aIFrame = CGRect(x: aIX, y: aIY, width: aIW, height: aIH)
        //        let image = UIImageView(frame: aIFrame)
        ////        image.image = UIImage(named: <#T##String#>)
        //        image.backgroundColor = UIColor.red
        
        //        self.addSubview(image)
        
        let head = UILabel(frame: aIFrame)
        head.text = "Soul"
        head.textAlignment = .center
        head.textColor = UIColor.black
        head.font = UIFont.systemFont(ofSize: 40)
        self.addSubview(head)
        
        // 文本
        let aHLX: CGFloat = aIX
        let aHLY: CGFloat = head.frame.maxY + 5
        let aHLW: CGFloat = 100
        let aHLH: CGFloat = 20
        let aHLFrame = CGRect(x: aHLX, y: aHLY, width: aHLW, height: aHLH)
        let headLabel = UILabel(frame: aHLFrame)
        headLabel.text = "跟随灵魂找到你"
        headLabel.textColor = UIColor.black
        headLabel.textAlignment = .center
        headLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(headLabel)
        
        let aLVW: CGFloat = 20
        let aLVX: CGFloat =  headLabel.frame.minX - aLVW - 20
        let aLVY: CGFloat = headLabel.frame.midY
        
        
        // 右侧是实线的应该放在文字的左边
        let frameFa = CGRect(x: aLVX, y: aLVY, width: aLVW, height: 1)
        let leftView = WYCircleLoadAnimationView(frame: frameFa, type: typeLocation.typeRight)
        self.addSubview(leftView)
        
        // 左侧是实线的应该放在文字的右边
        let aRVX: CGFloat = headLabel.frame.maxX + aLVW
        let frameF = CGRect(x: aRVX, y: aLVY, width: aLVW, height: 1)
        let rightView = WYCircleLoadAnimationView.init(frame: frameF, type: typeLocation.typeLeft)
        self.addSubview(rightView)
    }
}
