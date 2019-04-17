//
//  SVerifyCodeView.swift
//  SVerifyCodeDemo
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 整个屏幕的宽度
let kScreenWidth: CGFloat = UIScreen.main.bounds.width
/// 整个屏幕的d高度
let kScreenHeight: CGFloat = UIScreen.main.bounds.height

class SVerifyCodeView: UIView {

    /// 验证码输入框个数
    private var inputTextNum: Int = 6
    
    /// 验证码数量
    private var codeViews: [SVerifyCodeNumView] = []
    
    /// 验证码输入框距离两边的边距
    private var padding: CGFloat = 15
    
    /// 每个验证码输入框间距
    private var spacing: CGFloat = 10
    
    /// 是否在输入中
    private var isInput = true

    convenience init(inputTextNum: Int) {
        self.init()
        
        self.inputTextNum = inputTextNum
        
        initSubviews()
    }
}

// MARK:- 创建验证码输入框
extension SVerifyCodeView {
    /// 验证码输入框
    private func initSubviews() {
        
        // 每个验证码框宽度
        let itemWidth: CGFloat = (kScreenWidth - padding * 2 - spacing * (CGFloat(inputTextNum) - 1)) / CGFloat(inputTextNum)
        
        for i in 0..<inputTextNum {
            let codeNumView = SVerifyCodeNumView()
            codeNumView.isUserInteractionEnabled = false
            self.addSubview(codeNumView)
            
            let aCVX: CGFloat = padding + CGFloat(i) * (spacing + itemWidth)
            let aCVY: CGFloat = self.frame.origin.y
            let aCVW: CGFloat = itemWidth
            let aCVH: CGFloat = 90
            codeNumView.frame = CGRect(x: aCVX, y: aCVY, width: aCVW, height: aCVH)
            codeNumView.backgroundColor = UIColor.green
            codeViews.append(codeNumView)
//            codeNumView.setCursorStatus(true)
        }
    }
}
