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

    override func viewDidLoad() {
        super.viewDidLoad()

        /// app 名称
        let topicView = SLoginTopicView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: 100))
        self.view.addSubview(topicView)
        
        let imagView = SImageWithTitleView(frame: CGRect(x: 0, y: topicView.frame.maxY, width: kScreenWidth, height: 20))
        imagView.setData(image: "phone", text: "验证码")
        self.view.addSubview(imagView)
        
        
    }
}
