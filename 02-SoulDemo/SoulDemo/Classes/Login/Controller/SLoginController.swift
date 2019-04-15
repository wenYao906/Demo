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

        
        
        let slogin = SLoginView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        slogin.delegate = self
        self.view.addSubview(slogin)
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 隐藏导航栏
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK:- UIView
extension SLoginController: SLoginViewDelegate {
    
    func phoneAreaClick() {
        print("跳转到了 控制器 ")
        
        let phoneAreaVC = SPhoneAreaController()
        self.navigationController?.pushViewController(phoneAreaVC, animated: true)
    }
    
    func phoneTextField(text: String) {
        
        print("phoneTextField.text = \(text)")
    }
    
    func loginButtonClick(phoneNumber: String) {
        print("点击了 按钮 ")
    }
    
    func soulUserAgreementConsent() {
        print("点击了 同意协议")
    }
}
