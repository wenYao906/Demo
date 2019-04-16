//
//  SLoginController.swift
//  SoulDemo
//
//  Created by study on 2019/4/10.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class SLoginController: UIViewController {

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
        let sLoginBtn = SButtonView(frame: CGRect(x: 0, y: sPhoneView.frame.maxY + 30, width: kScreenWidth, height: 50))
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
        
        print("phoneTextField.text = \(text)")
    }
}

// MARK:- 登录按钮 - 代理
extension SLoginController: SButtonViewDelegate {
    
    func loginButtonClick() { // phoneNumber: String
        print("点击了 按钮 ")
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
