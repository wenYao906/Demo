//
//  ViewController.swift
//  倒计时
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        
//        //写一个按钮
//        btn.frame.size = CGSize(width: 100, height: 50)
//        btn.center = view.center
//        btn.backgroundColor = .red
//        view.addSubview(btn)
//
//        btn.addTarget(self, action: #selector(timeChange), for: .touchUpInside)
//        btn.setTitle("发送验证码", for: .normal)
    }
}

extension ViewController {
    
    @objc private func timeChange() {
        
        var time = 10
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
         //此处方法与Swift 3.0 不同
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))
        
        codeTimer.setEventHandler {
            
            time = time - 1
            
            DispatchQueue.main.async {
                self.btn.isEnabled = false
            }
            
            if time < 0 {
                codeTimer.cancel()
                DispatchQueue.main.async {
                    self.btn.isEnabled = true
                    self.btn.setTitle("重新发送", for: .normal)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.btn.setTitle("\(time)", for: .normal)
            }
            
        }
        
        codeTimer.activate()
        
    }
    

}

