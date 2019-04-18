//
//  WYCountdownButton.swift
//  倒计时
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class WYCountdownButton: UIView {
  
    /// 必须设置
    @IBInspectable
    public var identifier: String! {
        didSet {
            controller = WynCountdownController.shared(withIdentifier: identifier)
        }
    }
    /// 倒计时长
    @IBInspectable
    public var sec: Int = 60
    
    /// 倒数时按钮显示文字的 前缀
    @IBInspectable
    public var countingPrefix: String = ""
    /// 倒数时按钮显示文字的 后缀
    @IBInspectable
    public var countingSuffix: String = ""
    
    /// 自定义倒计时时显示的文字（每秒回调一次，closure设定后，前后缀的设定无效化）
    public var titleForCountingClosure: ((UIButton, Int) -> String)?
    public var attributedTitleForCountingClosure: ((UIButton, Int) -> NSAttributedString)?
    
    
    /// 倒计时开始、结束回调
    public var didCountdownBeginClosure: ((UIButton) -> Void)?
    public var didCountdownFinishClosure: ((UIButton) -> Void)?
    
    /* ============================================================ */
    // MARK: - Initilize
    /* ============================================================ */
    
    /// 初始化倒计时按钮
    ///
    /// - Parameters:
    ///   - sec: 倒计时长（秒）
    ///   - identifier: 唯一标示，用于恢复倒计时
    ///   - type: 按钮类型
    convenience init(sec: Int, type: ButtonType, identifier: String = "identifier") {
        self.init(type: type)
        
        self.sec = sec
        self.identifier = identifier
        self.controller = WynCountdownController.shared(withIdentifier: identifier)
        if controller.isTicking {
            self.start()
        }
    }
    
    /* ============================================================ */
    // MARK: - Public func
    /* ============================================================ */
    
    /// 开始倒计时
    @objc public func start() {
        
        isEnabled = false
        
        let tickingHandler: ((Timer, Int) -> Void)  = { [weak self](timer, currentVal) in
            guard let strongSelf = self else { return }
            
            strongSelf.handleTicking(currentVal: currentVal)
        }
        
        if controller.isTicking {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // 延时以等待设置TitleForCountingClosure
                self.handleTicking(currentVal: self.controller.currentVal)
                self.controller.tick = tickingHandler
            }
        } else {
            controller.begin(sec: sec, tickClosure: tickingHandler)
        }
        
        didCountdownBeginClosure?(self)
    }
    
    /* ============================================================ */
    // MARK: - Private properties & function
    /* ============================================================ */
    private weak var controller: WynCountdownController! {
        didSet {
            if controller.isTicking {
                self.start()
            }
        }
    }
    
    private func handleTicking(currentVal: Int) {
        
        if currentVal > 0 {
            if let closure = titleForCountingClosure {
                
                setTitle(closure(self, currentVal), for: .disabled)
                return
            }
            
            if let closure = attributedTitleForCountingClosure {
                
                setAttributedTitle(closure(self, currentVal), for: .disabled)
                return
            }
            
            setTitle("\(countingPrefix)\(currentVal)\(countingSuffix)", for: .disabled)
            
        } else {
            didCountdownFinishClosure?(self)
            isEnabled = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(start), for: .touchUpInside)
    }
    
    /// IB方式创建
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        /// 检查未填写identifier
        if identifier != nil && identifier != "" {
            self.controller = WynCountdownController.shared(withIdentifier: identifier)
        }
    }
}
---------------------
作者：iWaynn
来源：CSDN
原文：https://blog.csdn.net/imhwn/article/details/85015257
版权声明：本文为博主原创文章，转载请附上博文链接！
