//
//  SLoginTipsView.swift
//  SoulDemo
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol SLoginTipsViewDelegate: NSObjectProtocol {
    /// soul用户协议点击
    func soulUserAgreementConsent()
}


/// 登录界面的 下方的提示文本
class SLoginTipsView: UIView {
    /// 代理
    weak var delegate: SLoginTipsViewDelegate?
    /// 文本文字
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 确定按钮
        setupTipsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK:- 同意提示
extension SLoginTipsView {
    public func setupLabel(str: String, normalRange: NSRange, selectedRange: NSRange) {
        
        let aString = self.getNSAttributedString(str: str, normalRange: normalRange, selectedRange: selectedRange)
        label.attributedText = aString
    }
}

// MARK:- 同意提示
extension SLoginTipsView {
    // 同意提示
    private func setupTipsView() {
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.frame.size.height)
        self.addSubview(label)
        
        // 添加点击事件
        label.isUserInteractionEnabled = true
        let labelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelTouchUpInside(recognizer:)))
        label.addGestureRecognizer(labelTapGestureRecognizer)
    }
    
    @objc func labelTouchUpInside(recognizer: UITapGestureRecognizer) {
        //        let label = recognizer.view as! UILabel
         print("\(label.text) 被点击了")
        
        self.delegate?.soulUserAgreementConsent()
    }

    /// 指定字符 指定颜色并加上下划线
    ///
    /// - Parameters:
    ///   - str: 文字
    ///   - normalRange: 正常（普通）颜色的范围
    ///   - selectedRange: 高亮、带下划线的范围
    /// - Returns: 字符串
    func getNSAttributedString(str: String, normalRange: NSRange, selectedRange: NSRange) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString(string: str)
        
//        let range2 = NSMakeRange(7, 8)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: selectedRange)
        myMutableString.addAttribute(NSAttributedString.Key.underlineStyle , value: 0, range: normalRange)
        // 下划线
        myMutableString.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: selectedRange)
        
        return myMutableString
    }
}
