//
//  SaIconWithTitleView.swift
//  SoulDemo
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

//// 图片 和 标签  如：手机图片和标题（手机号登录）
class SImageWithTitleView: UIView {
    
    /// 左侧图片
    private let aIcon = UIImageView()
    /// 标题
    private let headLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 外界传值
extension SImageWithTitleView {
    open func setData(image: String, text: String) {
        aIcon.image = UIImage(named: image) 
        headLabel.text = text 
    }
}

// MARK:- 创建UI界面
extension SImageWithTitleView {
    /// 标签 - 图片(左) 和 文本框（右）
    private func setupTitleView(){
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
        self.addSubview(bgView)
        
        let aIW: CGFloat = 14
        let aIH: CGFloat = 18
        let aIX: CGFloat = 40
        let aIY: CGFloat = 0
        
        aIcon.frame = CGRect(x: aIX, y: aIY, width: aIW, height: aIH)
        bgView.addSubview(aIcon)
        
        // 文本
        let aHLX: CGFloat = 66
        let aHLW: CGFloat = 60

        headLabel.frame = CGRect(x: aHLX, y: aIY, width: aHLW, height: aIH)
        headLabel.textColor = UIColor.black
        headLabel.textAlignment = .center
        headLabel.font = UIFont.systemFont(ofSize: 14)
        
        bgView.addSubview(headLabel)
    }
}
