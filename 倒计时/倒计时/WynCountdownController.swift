//
//  WynCountdownController.swift
//  倒计时
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit
/// 全局的常量或变量都是延迟计算的，跟延迟存储属性相似，但全局的常量或变量不需要标记‘lazy’特性。
private var wynCountdownControllers: [String: WynCountdownController] = [:]

class WynCountdownController {
    /// 通过identifier来取得控制器实例
    static func shared(withIdentifier identifier: String) -> WynCountdownController {
        
        if let c = wynCountdownControllers[identifier] {
            return c
        } else {
            let c = WynCountdownController()
            c.identifier = identifier
            objc_sync_enter(wynCountdownControllers)
            wynCountdownControllers[identifier] = c
            objc_sync_exit(wynCountdownControllers)
            
            return c
        }
    }
    /// 只能通过shared(withIdentifier:)方法来实例化Controller
    private init() {}
    
    private var identifier: String!
    
    private var timer: Timer?
    
    /// 当前倒计时时间
    public var currentVal: Int = 60
    
    /// 当前状态
    public var isTicking = false
    /// 1秒1回调
    public var tick: ((Timer, Int) -> Void)!
    private func newTimer() {
        timer = Timer(fire: Date(), interval: 1, repeats: true) { [weak self](timer) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.currentVal -= 1
            strongSelf.tick(timer, strongSelf.currentVal)
            
            if strongSelf.currentVal <= 0 {
                strongSelf.isTicking = false
                
                timer.invalidate()
                strongSelf.timer = nil
                objc_sync_enter(wynCountdownControllers)
                wynCountdownControllers[strongSelf.identifier] = nil
                objc_sync_exit(wynCountdownControllers)
                
            }
        }
    }
    
    public func begin(sec: Int, tickClosure: @escaping (Timer, Int) -> Void) {
        currentVal = sec
        tick = tickClosure
        
        newTimer()
        RunLoop.current.add(self.timer!, forMode: .common)
        
        isTicking = true
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
}

