//
//  SLoginController.swift
//  SoulDemo
//
//  Created by study on 2019/4/10.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class SLoginController: UIViewController {

    /// 登录按钮
    var sLoginBtn = SButtonView()
    /// 手机号
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// app 名称
        let topicView = SLoginTopicView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: 100))
        self.view.addSubview(topicView)
        
        let imagView = SImageWithTitleView(frame: CGRect(x: 0, y: topicView.frame.maxY, width: kScreenWidth, height: 20))
        self.view.addSubview(imagView)
        
        /// 手机号码输入框
        let sPhoneView = SPhoneNumberView(frame: CGRect(x: 0, y: imagView.frame.maxY, width: kScreenWidth, height: 55))
        sPhoneView.delegate = self
        self.view.addSubview(sPhoneView)
        
        
        /// 登录按钮
        sLoginBtn = SButtonView(frame: CGRect(x: 0, y: sPhoneView.frame.maxY + 30, width: kScreenWidth, height: 50))
        sLoginBtn.delegate = self
        self.view.addSubview(sLoginBtn)
        
        
        /// 提示
        let sTipsView = SLoginTipsView(frame: CGRect(x: 0, y: sLoginBtn.frame.maxY, width: kScreenWidth, height: kScreenHeight - sLoginBtn.frame.maxY))
        sTipsView.delegate = self
        self.view.addSubview(sTipsView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 隐藏导航栏
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK:- UIView
extension SLoginController: SPhoneNumberViewDelegate {
    
    func phoneAreaClick() {
        print("跳转到了 控制器 ")
        
        let phoneAreaVC = SPhoneAreaController()
        self.navigationController?.pushViewController(phoneAreaVC, animated: true)
    }
    
    func phoneTextField(text: String) {
        /*
         让按钮无法点击的2种方法
         1.button.enabled = NO; 此时会进入UIControlStateDisabled
         2.button.userInterctionEnabled = NO;此时不会进入UIControlStateDisabled，继续保持当前的状态
         */
        if text.count == 11 { // 可以点击
            sLoginBtn.setButtonEnabled(enabled: true, color: UIColor.blue)
            // 给 手机号变量 赋值
            phoneNumber = text
        } else {// 不可点击
            let aColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)
            sLoginBtn.setButtonEnabled(enabled: false, color: aColor)
        }
    }
}

// MARK:- 登录按钮 - 代理
extension SLoginController: SButtonViewDelegate {
    
    func loginButtonClick() { // phoneNumber: String
        print("点击了 按钮 ")
        
        if (phoneNumber.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)  {
            print("手机号不能为空")
            return
        }

        if phoneNumber.count != 11 {
            print("手机号码不正确")
            return
        }

        /// 判断手机号是否正确
        if  !isTelNumber(num: phoneNumber) {
            print("手机号码不正确")
            return
        }
        
        print("phoneNumber = \(phoneNumber), 进行跳转")
    }
}

// MARK:- 同意协议 - 代理
extension SLoginController: SLoginTipsViewDelegate {
    
    func soulUserAgreementConsent() {
        print("点击了 同意协议")
        
        let agreeVC = SAgreementController()
        self.navigationController?.pushViewController(agreeVC, animated: true)
    }
}
