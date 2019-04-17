//
//  ViewController.swift
//  SVerifyCodeDemo
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var codeView: SVerifyCodeView = {
        let codeView =  SVerifyCodeView (inputTextNum: 4)
        self.view.addSubview(codeView)
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeView.frame = CGRect(x: 0, y: 80, width: kScreenWidth, height: 90)
        codeView.backgroundColor = UIColor.red
        
    }
}

