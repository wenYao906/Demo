//
//  SPhoneNumberView.swift
//  SoulDemo
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol SPhoneNumberViewDelegate: NSObjectProtocol {
    /// 手机号区号
    func phoneAreaClick()
    /// 手机号文本框
    func phoneTextField(text: String)
}

/// 区号 + 手机号码
class SPhoneNumberView: UIView {
    /// 手机号输入框
    private let phoneField = UITextField()
    /// 手机号 - 区号
    private let areaBtn = UIButton()
    /// 代理
    weak var delegate: SPhoneNumberViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPhoneFieldView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 点击事件
extension SPhoneNumberView {
    /// 点击了区域按钮，显示各个国家的手机号区域
    @objc private func setAreaNumberClick() {
        print("跳转到一个界面，显示各个国家的手机号区域")
        
        delegate?.phoneAreaClick()
    }
    
    /// 手机号输入框
    @objc func actButton(textField: UITextField){
        let text = textField.text ?? ""
        self.delegate?.phoneTextField(text: text)
    }
}

// MARK:- 手机号码 View
extension SPhoneNumberView {
    // 手机号码输入框 ： 区域按钮 和 文本输入框
    private func setupPhoneFieldView() {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 55))
        self.addSubview(bgView)
        
        // 区域号码
        areaBtn.frame = CGRect(x: 35, y: 0, width: 50, height: 54)
        areaBtn.setTitle(" +86 ", for: .normal)
        areaBtn.setTitleColor(UIColor.black, for: .normal)
        areaBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        areaBtn.addTarget(self, action: #selector(setAreaNumberClick), for: .touchUpInside)
        bgView.addSubview(areaBtn)
        
        // 手机号输入框
        phoneField.placeholder = "在这里输入手机号"
        phoneField.font = UIFont.systemFont(ofSize: 20.0)
        phoneField.addTarget(self, action: #selector(self.actButton(textField:)), for: .editingChanged)
        phoneField.keyboardType = .numberPad
        
        let aTFX: CGFloat = 117
        let aTFW: CGFloat = kScreenWidth - 40 * 2 - areaBtn.frame.width
        let aTFH: CGFloat = 54
        let aTFY: CGFloat = 0
        phoneField.frame = CGRect(x: aTFX, y: aTFY, width: aTFW, height: aTFH)
        
        bgView.addSubview(phoneField)
        
        // 底部的线
        let line = UILabel(frame: CGRect(x: 40, y: phoneField.frame.maxY + 1, width: kScreenWidth - 40 * 2, height: 0.5))
        line.backgroundColor = UIColor.gray
        bgView.addSubview(line)
    }
}


