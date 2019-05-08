//
//  LoginView.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/3/4.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: NSObjectProtocol {
    /// 点击了 “ 手机号登录”
    func loginPhotoClick(LoginView: LoginView)
    /// 点击了 "账号登录"
    func loginUserNameClick(LoginView: LoginView)
    /// 点击了 "微信登录"
    func loginWeiXinClick(LoginView: LoginView)
    /// 点击了 "QQ登录"
    func loginQQClick(LoginView: LoginView)
}

/// 登录界面
class LoginView: UIView {

    /// 手机号登录注册
    let aPhoneBtn = UIButton()
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    private func setupUIView() {
       
        
        // 手机号登录注册View
        let phoneX: CGFloat = 26
        let phoneY: CGFloat = 0
        let phoneW: CGFloat = kScreenWidth - phoneX * 2
        let phoneH: CGFloat = 70

        let photoView = setupPhoneLoginView(frame: CGRect(x: phoneX, y: phoneY, width: phoneW, height: phoneH))
        addSubview(photoView)
        
        // 微信登录，qq登录，账号登录View
        let otherLoginView = setupOtherLoginView()
        addSubview(otherLoginView)
    }
    
    /// 手机号登录注册View
    private func setupPhoneLoginView(frame: CGRect) -> UIView {
        
        aPhoneBtn.frame = frame
        aPhoneBtn.layer.cornerRadius = 16
        aPhoneBtn.setTitle("手机号登录注册", for: .normal)
        aPhoneBtn.addTarget(self, action: #selector(setPhoneLoginClick), for: .touchUpInside)
        aPhoneBtn.clipsToBounds = true
        aPhoneBtn.backgroundColor = UIColor.black
        aPhoneBtn.setTitleColor(UIColor.white, for: .normal)
        aPhoneBtn.setTitleColor(UIColor.white, for: .normal)
        
        return aPhoneBtn
    }
    

    
    /// 微信登录，qq登录，账号登录View
    private func setupOtherLoginView() -> UIView {
        let bgView = UIView(frame: CGRect(x: 26, y: 70, width: kScreenWidth - 26 * 2, height: 72))
//        bgView.backgroundColor = UIColor.red
//        addSubview(bgView)
        
        // 中间间隔宽度 = (整个m屏幕的宽度 - 两边的距离 - 微信登录等3个btn的宽度) / 2个间距
        let aMargin =  (kScreenWidth - 26 * 2 - 80 * 3 ) / 2
        
        // 微信 登录
        let awxW: CGFloat = 80
        let awxX: CGFloat = 0
        let awxY: CGFloat = 27
        let awxH: CGFloat = 18
        
        let titleFont = UIFont.systemFont(ofSize: 15)
        
        let weixinImage = UIButton.init(type: .custom)
        weixinImage.frame = CGRect(x: awxX, y: awxY, width: awxW, height: awxH)
        weixinImage.setImage(UIImage(named: "weixin2"), for: .normal)
        weixinImage.setTitle("微信登录", for: .normal)
        weixinImage.setTitleColor(UIColor.white, for: .normal)
        weixinImage.titleLabel?.font = titleFont
        weixinImage.addTarget(self, action: #selector(setWeiXinLoginClick), for: .touchUpInside)
        
        bgView.addSubview(weixinImage)
        
        // QQ 登录
        let qqImage = UIButton.init(type: .custom)
        qqImage.frame = CGRect(x: weixinImage.frame.maxX + aMargin, y: awxY, width: awxW, height: awxH)
        qqImage.setImage(UIImage(named: "QQ2"), for: .normal)
        qqImage.setTitle("QQ登录", for: .normal)
        qqImage.setTitleColor(UIColor.white, for: .normal)
        qqImage.titleLabel?.font = titleFont
        qqImage.addTarget(self, action: #selector(setQQLoginClick), for: .touchUpInside)
        bgView.addSubview(qqImage)
        
        // 账号登录
        let userNameBtn = UIButton.init(type: .custom)
        userNameBtn.frame = CGRect(x: qqImage.frame.maxX + aMargin, y: awxY, width: awxW, height: awxH)
        userNameBtn.setImage(UIImage(named: "userName2"), for: .normal)
        userNameBtn.setTitle("账号登录", for: .normal)
        userNameBtn.setTitleColor(UIColor.white, for: .normal)
        userNameBtn.titleLabel?.font = titleFont
        userNameBtn.addTarget(self, action: #selector(setUserNameLoginClick), for: .touchUpInside)
        bgView.addSubview(userNameBtn)
        
        return bgView
    }
}

// MARK: - 点击每个登录按钮后的操作
extension LoginView {
    /// 手机号登录注册
    @objc private func setPhoneLoginClick() {
        delegate?.loginPhotoClick(LoginView: self)
    }
    
    /// 微信登录
    @objc private func setWeiXinLoginClick() {
        delegate?.loginWeiXinClick(LoginView: self)
    }
    
    /// qq 登录
    @objc private func setQQLoginClick() {
        delegate?.loginQQClick(LoginView: self)
    }
    
    /// 账号登录
    @objc private func setUserNameLoginClick() {
        delegate?.loginUserNameClick(LoginView: self)
    }
}


