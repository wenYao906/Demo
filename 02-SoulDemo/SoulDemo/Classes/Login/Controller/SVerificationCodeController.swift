//
//  SVerificationCodeController.swift
//  SoulDemo
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 发送验证码界面
class SVerificationCodeController: UIViewController {

    // 验证码 - 手机号
    public var tipsNumber = "13145454647"
    
    /// 登录按钮
    private var sLoginBtn = SButtonView()
    /// 验证码
    private var verifiCode = ""
    
    
    lazy var codeView: SVerifyCodeView = {
        let codeView =  SVerifyCodeView (inputTextNum: 4)
        self.view.addSubview(codeView)
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// app 名称
        let topicView = SLoginTopicView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: 100))
        self.view.addSubview(topicView)
        
        let imagView = SImageWithTitleView(frame: CGRect(x: 0, y: topicView.frame.maxY, width: kScreenWidth, height: 20))
        imagView.setData(image: "phone", text: "验证码")
        self.view.addSubview(imagView)
        
        
        codeView.frame = CGRect(x: 0, y: imagView.frame.maxY, width: kScreenWidth, height: 90)
        codeView.textFiled.becomeFirstResponder()
        
        let aColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)

        // 监听验证码输入的过程
        codeView.textValueChange = { str in
            // 要做的事情
            
            print("监听验证码输入的过程  ---- str = \(str)")
            
            // 监听没有完毕，按钮不可以点击
            self.sLoginBtn.setButtonEnabled(enabled: false, color: aColor)
        }
        
        // 监听验证码输入完成
        codeView.inputFinish = { str in
            // 要做的事情
            self.verifiCode = str
            // 监听完毕，按钮可以点击
            self.sLoginBtn.setButtonEnabled(enabled: true, color: UIColor.blue)

            print("监听验证码输入完成  ----  str = \(str)")
        }
        
        let tipsLabel = UILabel(frame: CGRect(x: 0, y: codeView.frame.maxY + 20, width: kScreenWidth, height: 16))
        tipsLabel.text = "已发送验证码至 \(tipsNumber)"
        tipsLabel.textColor = UIColor.gray
        tipsLabel.font = UIFont.systemFont(ofSize: 14)
        tipsLabel.textAlignment = .center
        self.view.addSubview(tipsLabel)
        
        /// 登录按钮
        sLoginBtn = SButtonView(frame: CGRect(x: 0, y: tipsLabel.frame.maxY + 40, width: kScreenWidth, height: 50))
        sLoginBtn.delegate = self
        self.view.addSubview(sLoginBtn)
        
        /// 提示
        let sTipsView = SLoginTipsView(frame: CGRect(x: 0, y: sLoginBtn.frame.maxY + 40, width: kScreenWidth, height: 20))
        sTipsView.setupLabel(str: "没有收到验证码", normalRange: NSMakeRange(0, 0), selectedRange: NSMakeRange(0, 7))
        sTipsView.delegate = self
        self.view.addSubview(sTipsView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // 隐藏导航栏
        self.navigationController?.navigationBar.isHidden = true
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("")
//        print("touchesBegan")
//
//        view.endEditing(true)
//    }
}

// MARK:- 登录按钮 - 代理
extension SVerificationCodeController: SButtonViewDelegate {
    
    func loginButtonClick() { // phoneNumber: String
        print("点击了 按钮 ")
        
        // 验证码
        // 走 密码界面
    }
}
// MARK:- 同意协议 - 代理
extension SVerificationCodeController: SLoginTipsViewDelegate {
    
    func soulUserAgreementConsent() {
        print("点击了 没有收到验证码")
        
        // 跳转到意见反馈
        
//        let agreeVC = SAgreementController()
//        self.navigationController?.pushViewController(agreeVC, animated: true)
    }
}
