//
//  SLoginView.swift
//  SoulDemo
//
//  Created by study on 2019/4/10.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol SLoginViewDelegate: NSObjectProtocol {
    /// 手机号区号
    func phoneAreaClick()
    /// 手机号文本框
    func phoneTextField(text: String)
    /// 确定按钮
    func loginButtonClick(phoneNumber: String)
    /// soul用户协议点击
    func soulUserAgreementConsent()

}

class SLoginView: UIView {

    /// 手机号输入框
    private let phoneField = UITextField()
    /// 手机号 - 区号
    private let areaBtn = UIButton()
    /// 代理
    weak var delegate: SLoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeaderView()
        
        setupPhoneNumberView()
        
        setupBottonView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 点击事件
extension SLoginView {
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
    
    /// 确定按钮
    @objc private func loginClick() {
        
        let phoneText = phoneField.text!
        
        if (phoneText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)  {
            print("手机号不能为空")
            return
        }
        
        if phoneText.count != 11 {
            print("手机号码不正确")
            return
        }
        
        /// 判断手机号是否正确
        if  !isTelNumber(num: phoneText) {
            print("手机号码不正确")
            return
        }

        let text = phoneField.text ?? ""
        delegate?.loginButtonClick(phoneNumber: text)
    }
}



// MARK:- app名称
extension SLoginView {
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

// MARK:- 手机号码 View
extension SLoginView {
    private func setupPhoneNumberView() {
        setupTitleView()
        setupPhoneFieldView()
        // 确定按钮
        setupBtnView()
    }
    
    /// 标签 - 图片(左) 和 文本框（右）
    private func setupTitleView() {
        let aIW: CGFloat = 14
        let aIH: CGFloat = 18
        let aIX: CGFloat = 40
        let aIY: CGFloat = 210
        let aIFrame = CGRect(x: aIX, y: aIY, width: aIW, height: aIH)
        let image = UIImageView(frame: aIFrame)
        image.image = UIImage(named: "phone")
        
        self.addSubview(image)
        
        
        // 文本
        let aHLX: CGFloat = 66
        let aHLW: CGFloat = 60
        let aHLFrame = CGRect(x: aHLX, y: aIY, width: aHLW, height: aIH)
        let headLabel = UILabel(frame: aHLFrame)
        headLabel.text = "手机号码"
        headLabel.textColor = UIColor.black
        headLabel.textAlignment = .center
        headLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(headLabel)
    }
    
    // 手机号码输入框 ： 区域按钮 和 文本输入框
    private func setupPhoneFieldView() {
        
        // 区域号码
        areaBtn.frame = CGRect(x: 35, y: 234, width: 50, height: 54)
        areaBtn.setTitle(" +86 ", for: .normal)
        areaBtn.setTitleColor(UIColor.black, for: .normal)
        areaBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        areaBtn.addTarget(self, action: #selector(setAreaNumberClick), for: .touchUpInside)
        self.addSubview(areaBtn)
    
        // 手机号输入框
        phoneField.placeholder = "在这里输入手机号"
        phoneField.font = UIFont.systemFont(ofSize: 20.0)
        phoneField.addTarget(self, action: #selector(self.actButton(textField:)), for: .editingChanged)
        phoneField.keyboardType = .numberPad
        
        let aTFX: CGFloat = 117
        let aTFW: CGFloat = kScreenWidth - 40 * 2 - areaBtn.frame.width
        let aTFH: CGFloat = 54
        let aTFY: CGFloat = 234
        phoneField.frame = CGRect(x: aTFX, y: aTFY, width: aTFW, height: aTFH)
        
        self.addSubview(phoneField)
        
        // 底部的线
        let line = UILabel(frame: CGRect(x: 40, y: phoneField.frame.maxY + 1, width: kScreenWidth - 40 * 2, height: 0.5))
        line.backgroundColor = UIColor.gray
        self.addSubview(line)
    }
    
    /// 确定按钮
    private func setupBtnView() {
        // 确定
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = UIColor.gray
        
        let aLBW: CGFloat = 160
        let aLBH: CGFloat = 46
        let aLBX: CGFloat = (kScreenWidth - aLBW) * 0.5
        // 1.5: 底部线的高度
        let aLBY: CGFloat = phoneField.frame.maxY + 1.5 + 65
        
        loginBtn.frame = CGRect(x: aLBX, y: aLBY, width:aLBW, height: aLBH)
        loginBtn.layer.cornerRadius = 16
        loginBtn.setTitle("确定", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        loginBtn.backgroundColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(loginBtn)
    }
}

// MARK:- 同意提示
extension SLoginView {
    // 同意提示
    private func setupBottonView() {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)

        label.frame = CGRect(x: 0, y: self.frame.height - 20 * 2, width: kScreenWidth, height: 20)
        
        self.addSubview(label)
        
//        let str = "我已阅读并同意Soul用户协议"
        let sub = "我已阅读并同意Soul用户协议"
        label.attributedText = self.getNSAttributedString(str: sub)
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
