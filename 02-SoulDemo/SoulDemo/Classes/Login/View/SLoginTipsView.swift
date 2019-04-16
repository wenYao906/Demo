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
    // 同意提示
    private func setupTipsView() {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.frame = CGRect(x: 0, y: self.frame.height - 20 * 2, width: kScreenWidth, height: 20)
        self.addSubview(label)
        
        let sub = "我已阅读并同意Soul用户协议"
        label.attributedText = self.getNSAttributedString(str: sub)
        
        // 添加点击事件
        label.isUserInteractionEnabled = true
        let labelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelTouchUpInside(recognizer:)))
        label.addGestureRecognizer(labelTapGestureRecognizer)
    }
    
    @objc func labelTouchUpInside(recognizer: UITapGestureRecognizer) {
        //        let label = recognizer.view as! UILabel
        // print("\(label.text) 被点击了")
        
        self.delegate?.soulUserAgreementConsent()
    }
    
    
    //指定字符 指定颜色并加上下划线
    func getNSAttributedString(str:String) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString(string: str)
        
        let range2 = NSMakeRange(7, 8)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range2)
        myMutableString.addAttribute(NSAttributedString.Key.underlineStyle , value: 0, range: NSMakeRange(0, 6))
        // 下划线
        myMutableString.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: range2)
        
        return myMutableString
    }
}
