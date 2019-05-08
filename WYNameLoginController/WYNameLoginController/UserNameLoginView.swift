//
//  UserNameLoginView.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/2/28.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import UIKit

protocol UserNameLoginViewDelegate: NSObjectProtocol {
    /// 点击了登录按钮
    func loginButtonClick(LoginView: UserNameLoginView, userName: String, password: String)
    /// 点击了 “ 手机号验证码登录”
    func loginPhotoClick(LoginView: UserNameLoginView)
    /// 点击了 "选择区号"
    func loginAreaClick(LoginView: UserNameLoginView)
    /// 点击了 "微信登录"
    func loginWeiXinClick(LoginView: UserNameLoginView)
    /// 点击了 "QQ登录"
    func loginQQClick(LoginView: UserNameLoginView)
}

class UserNameLoginView: UIView {

    // 头像
    private let aPhoto = UIImageView()
    
    /// 账号
    let aTFPhone =  UITextField()
    /// 密码
    let aTFPassword =  UITextField()
    
    weak var delegate: UserNameLoginViewDelegate?
    
    //////// frame值 ////////
    /// x的值
    private let loginXSpace: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1. 头像
        setUpUIViewWithPhoto()
        
        // 2. 账号登录界面
        let nameAndPwdView = setUIViewWithLoginView()
        self.addSubview(nameAndPwdView)
        
        // 3. 登录按钮
        let lgBtn = CGRect(x: loginXSpace, y: nameAndPwdView.frame.maxY + 35, width: nameAndPwdView.frame.width, height: 88)
        let loginBtnView = setupUIViewWithLoginBtn(frame: lgBtn)
        self.addSubview(loginBtnView)
        
        // 4. 快速登录View
        print("frame.maxY = \(frame.maxY)")
        let fastLoginF: CGRect = CGRect(x: 0, y: kScreenHeight - 140 - 64, width: kScreenWidth, height: 140)
        setupUIViewWithFastLogin(frame: fastLoginF)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 快速登录View
extension UserNameLoginView {
    /// 手机号验证码登录
    @objc private func setPhoneClick() {
        delegate?.loginPhotoClick(LoginView: self)
    }
    
    /// 选择区号
    @objc private func setAreaCodeClick() {
        delegate?.loginAreaClick(LoginView: self)
    }
}

// MARK: - 登录按钮的点击事件
extension UserNameLoginView {
    /// 微信登录
    @objc private func setWeiXinLoginClick() {
        delegate?.loginWeiXinClick(LoginView: self)
    }
    
    /// QQ 登录
    @objc private func setQQLoginClick() {
        delegate?.loginQQClick(LoginView: self)
    }
}


// MARK: - 头像 View
extension UserNameLoginView {
    /// 头像 View 80 * 80
    private func setUpUIViewWithPhoto() {
        let aPY: CGFloat = 0
        let aPW: CGFloat = 80
        let aPH: CGFloat = 80

        aPhoto.frame = CGRect(x: loginXSpace, y: aPY, width: aPW, height: aPH)
        aPhoto.image = UIImage(named: "IPhoto")
        addSubview(aPhoto)
    }
}

// MARK: - 用户名和密码 View
extension UserNameLoginView {
    
    /// 用户名和密码 View
    private func setUIViewWithLoginView() -> UIView {
        
        /// 背景View
        let centerView = UIView()
        let aCY: CGFloat = aPhoto.frame.maxY + 16
        let aCW: CGFloat = kScreenWidth - 2 * loginXSpace
        let aCH: CGFloat = 148

        centerView.frame = CGRect(x: loginXSpace, y: aCY, width: aCW, height: aCH)
        
        // 账号登录 Label
        let aLFY: CGFloat = 0
        let aLFW: CGFloat = 100
        let aLFH: CGFloat = 26
        let aLframe = CGRect(x: 0, y: aLFY, width: aLFW, height: aLFH)
        let aLabel = UILabel(frame: aLframe)
        aLabel.text = "账号登录"
        aLabel.font = UIFont.systemFont(ofSize: 22)
        aLabel.textColor = UIColor(red: 48/255.0, green: 49/255.0, blue: 49/255.0, alpha: 1)
        aLabel.textAlignment = .left
        centerView.addSubview(aLabel)
        
        // UITexField 高度
        let tfHeight: CGFloat = frameLoginView.FNameAndPwd.frame
        // UITexField下边线的高度
        let tfLine: CGFloat = frameLoginView.Fline.frame
        
        // 简约号/邮箱/手机号
        aTFPhone.frame = CGRect(x: 0, y: aLabel.frame.maxY, width: centerView.frame.width, height: tfHeight)
        aTFPhone.placeholder = "简约号/邮箱/手机号"
        aTFPhone.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        aTFPhone.delegate = self
        aTFPhone.font = UIFont.systemFont(ofSize: 16)
        centerView.addSubview(aTFPhone)
        
        let phoneLine = UIView.init(frame: CGRect(x: 0, y: aTFPhone.frame.maxY, width: centerView.frame.width, height: tfLine))
        phoneLine.backgroundColor = kWangjiColor
        centerView.addSubview(phoneLine)

        // 登录密码
        aTFPassword.frame = CGRect(x: 0, y: aTFPhone.frame.maxY , width: centerView.frame.width, height: tfHeight)
        aTFPassword.delegate = self
        aTFPassword.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        aTFPassword.placeholder = "输入登录密码"
        aTFPassword.font = UIFont.systemFont(ofSize: 16)
        centerView.addSubview(aTFPassword)
        
        let passwordLine = UIView.init(frame: CGRect(x: 0, y: aTFPassword.frame.maxY, width: centerView.frame.width, height: tfLine))
        passwordLine.backgroundColor = kWangjiColor
        centerView.addSubview(passwordLine)
        
        
        return centerView
    }
}

// MARK: - 登录View
extension UserNameLoginView {
    private func setupUIViewWithLoginBtn(frame: CGRect) -> UIView{
        let bgView = UIView(frame: frame)
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = UIColor.white
        
        let aLBW: CGFloat = kScreenWidth - 2 * loginXSpace
        let aLBH: CGFloat = frameLoginView.FLoginBtn.frame
            
        loginBtn.frame = CGRect(x: 0, y: 0, width:aLBW, height: aLBH)
        loginBtn.layer.cornerRadius = 16
        loginBtn.setTitle("登 录", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        loginBtn.backgroundColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        bgView.addSubview(loginBtn)

        
        let iPhoneIdentifyCode = UIButton.init(type: .custom)
        iPhoneIdentifyCode.frame = CGRect(x: 0, y: loginBtn.frame.maxY + 13, width:120, height: 16)
        iPhoneIdentifyCode.setTitle("手机号验证码登录", for: .normal)
        iPhoneIdentifyCode.setTitleColor(kWangjiColor, for: .normal)
        iPhoneIdentifyCode.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        iPhoneIdentifyCode.addTarget(self, action: #selector(setPhoneClick), for: .touchUpInside)
        bgView.addSubview(iPhoneIdentifyCode)

        
        let areaCodeBtn = UIButton.init(type: .custom)
        areaCodeBtn.frame = CGRect(x: bgView.frame.width - 90, y: loginBtn.frame.maxY + 15, width: 90, height: 16)
        areaCodeBtn.setTitle("选择区号", for: .normal)
        areaCodeBtn.setTitleColor(kWangjiColor, for: .normal)
        areaCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        areaCodeBtn.addTarget(self, action: #selector(setAreaCodeClick), for: .touchUpInside)

        bgView.addSubview(areaCodeBtn)
        
        return bgView
    }
}


// MARK: - 快速登录View
extension UserNameLoginView {
    private func setupUIViewWithFastLogin(frame: CGRect) {
        let bgView = UIView(frame: frame)
        addSubview(bgView)
        
        // 左边的线
        let leftWidth: CGFloat = kScreenWidth - 2 * 10
        let leftLine = UILabel(frame: CGRect(x: 10, y: 7, width: leftWidth, height: 0.5))
        leftLine.backgroundColor = kWangjiColor
        bgView.addSubview(leftLine)
        
        // 中间文字
        let aLWidth: CGFloat = 100
        let aLX: CGFloat = (bgView.frame.width - aLWidth) * 0.5
        let aLabel = UILabel(frame: CGRect(x: aLX, y: 0, width: aLWidth, height: 15))
        aLabel.text = "快速登录"
        aLabel.backgroundColor = UIColor.white
        aLabel.font = UIFont.systemFont(ofSize: 12)
        aLabel.textColor = kWangjiColor
        aLabel.textAlignment = .center
        bgView.addSubview(aLabel)
        
        // 微信图标
        let awxW: CGFloat = 60
        let awxX: CGFloat = kScreenWidth * 0.5 - awxW - 15
        let awxY: CGFloat = (bgView.frame.height - awxW - aLabel.frame.height) * 0.5

        let weixinImage = UIButton.init(type: .custom)
        weixinImage.frame = CGRect(x: awxX, y: awxY, width: awxW, height: awxW)
        weixinImage.setImage(UIImage(named: "weixin"), for: .normal)
        weixinImage.addTarget(self, action: #selector(setWeiXinLoginClick), for: .touchUpInside)
        
        bgView.addSubview(weixinImage)

        // QQ图标
        let qqImage = UIButton.init(type: .custom)
        qqImage.frame = CGRect(x: kScreenWidth * 0.5 + 15, y: awxY, width: awxW, height: awxW)
        qqImage.setImage(UIImage(named: "QQ"), for: .normal)
        qqImage.addTarget(self, action: #selector(setQQLoginClick), for: .touchUpInside)
        bgView.addSubview(qqImage)
    }
}

// MARK: - 登录按钮的点击事件
extension UserNameLoginView {
    @objc private func loginClick() {
        
        if (aTFPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) || (aTFPhone.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            print("用户名和密码不能为空")
            return
        }
        
        delegate?.loginButtonClick(LoginView: self, userName: aTFPhone.text ?? "", password: aTFPassword.text ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension UserNameLoginView: UITextFieldDelegate {
    // MARK:- 5 点击手势
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//        loginFallingAnimate()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        loginRisingAnimate()
        return true
    }
    // MARK:- 3 uitextfield编辑完成后逻辑处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        loginFallingAnimate()
        return true
    }
}

// MARK:- 界面用到的Frame值
enum frameLoginView {
    /// 头像
    case FPhoto
    /// 账号登录高度
    case FNameTitleView
    /// 用户号和密码的高度
    case FNameAndPwd
    /// 用户号和密码下方线的高度
    case Fline
    /// 登录按钮高度
    case FLoginBtn
    ///  靠近边界的x值
    case Fx
    /// 手机号验证码登录高度
    case FPhoneL
    /// 快速登录高度
    case FFastLoginView
    
    
    var frame: CGFloat {
        switch self {
        case .FPhoto:
            return 80
        case .FNameTitleView:
            return 26
        case .FNameAndPwd:
            return 60
        case .Fline:
            return 0.5
        case .FLoginBtn:
            return 60
        case .Fx:
            return 30
        case .FPhoneL:
            return 14
        case .FFastLoginView:
            return 126
        }
    }
}

public let kWangjiColor:UIColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1)
