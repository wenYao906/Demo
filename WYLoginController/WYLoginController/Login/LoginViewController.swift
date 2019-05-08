
//
//  LoginViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/6.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height

class LoginViewController: UIViewController {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        view.backgroundColor = UIColor.white
        
        let logFrame = CGRect(x: 0, y: kScreenHeight - 140, width: kScreenWidth, height: 140)
        let loginView = LoginView(frame: logFrame)
        loginView.backgroundColor = UIColor.orange
        loginView.delegate = self
        self.view.addSubview(loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 隐藏导航栏
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginPhotoClick(LoginView: LoginView) {
        print("点击了 手机号登录注册")
    }
    
    func loginUserNameClick(LoginView: LoginView) {
        print("点击了 账号登录")
        
//        let usernameView = UserNameController()
//        self.navigationController?.pushViewController(usernameView, animated: true)
    }
    
    func loginWeiXinClick(LoginView: LoginView) {
        print("点击了 微信登录")
    }
    
    func loginQQClick(LoginView: LoginView) {
        print("点击了 QQ登录")
    }
}
