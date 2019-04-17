//
//  ViewController.swift
//  SVerifyCodeDemo
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let array = Array
    lazy var codeView: SVerifyCodeView = {
        let codeView =  SVerifyCodeView (inputTextNum: 4)
        self.view.addSubview(codeView)
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeView.frame = CGRect(x: 0, y: 80, width: kScreenWidth, height: 90)        
        codeView.textFiled.becomeFirstResponder()
        
        // 监听验证码输入的过程
        codeView.textValueChange = { str in
            // 要做的事情
        }
        
        // 监听验证码输入完成
        codeView.inputFinish = { str in
            // 要做的事情
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

