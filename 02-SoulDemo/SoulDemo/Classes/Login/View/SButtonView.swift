//
//  SButtonView.swift
//  SoulDemo
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol SButtonViewDelegate: NSObjectProtocol {
    /// 确定按钮
    func loginButtonClick()
//    func loginButtonClick(phoneNumber: String)
}

/// 确认按钮
class SButtonView: UIView {

    private let loginBtn = UIButton()
    
    /// 代理
    weak var delegate: SButtonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 确定按钮
        setupBtnView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 外部事件
extension SButtonView {
    func setButtonEnabled(enabled: Bool, color: UIColor) {
        loginBtn.backgroundColor = color
        loginBtn.isUserInteractionEnabled = enabled
    }
}

// MARK:- 点击事件
extension SButtonView {
    /// 确定按钮
    @objc private func loginClick() {
        delegate?.loginButtonClick()
    }
}

// MARK:- 确定按钮
extension SButtonView {
    /// 确定按钮
    private func setupBtnView() {
        // 确定
        let aLBW: CGFloat = 160
        let aLBH: CGFloat = 46
        let aLBX: CGFloat = (kScreenWidth - aLBW) * 0.5
        // 1.5: 底部线的高度
        let aLBY: CGFloat = 0
        
        loginBtn.frame = CGRect(x: aLBX, y: aLBY, width:aLBW, height: aLBH)
        loginBtn.layer.cornerRadius = 16
        loginBtn.setTitle("确定", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        loginBtn.backgroundColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        self.addSubview(loginBtn)
    }
}
