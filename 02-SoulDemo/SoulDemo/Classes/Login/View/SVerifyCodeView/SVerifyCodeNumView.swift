//
//  SVerifyCodeNumView.swift
//  SVerifyCodeDemo
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class SVerifyCodeNumView: UIView {

    /// 数字
    private let numLabel = UILabel()
    
    /// 下划线
    private let lineView = UIView ()
    /// 宽度
    open var aWidthFrame: CGFloat = 0
    
    /// 光标
    lazy var cursor: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        shapeLayer.add(opacityAnimation, forKey: "kOpacityAnimation")
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }()

    /// 闪烁动画
    fileprivate var opacityAnimation: CABasicAnimation = {
        let opacityAnimation = CABasicAnimation.init(keyPath: "opacity")
        // 属性初始值
        opacityAnimation.fromValue = 1.0
        // 属性要到达的值
        opacityAnimation.toValue = 0.0
        // 动画时间
        opacityAnimation.duration = 0.9
        // 重复次数(无穷大)
        opacityAnimation.repeatCount = HUGE
        /*
         removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
         */
        opacityAnimation.isRemovedOnCompletion = true
        // 决定当前对象在非active时间段的行为。比如动画开始之前或者动画结束之后
        opacityAnimation.fillMode = CAMediaTimingFillMode.forwards
        // 速度控制函数，控制动画运行的节奏
        /*
         kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
         kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
         kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
         kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
         */
        opacityAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeIn)
        return opacityAnimation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIView()
        

        NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(enterBack), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath.init(rect: CGRect.init(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.1, width: 1, height: self.frame.size.height * 0.7))
        cursor.path = path.cgPath
        
        let aNLX: CGFloat = 0
        let aNLY: CGFloat = 0
        let aNLW: CGFloat = aWidthFrame
        let aNLH: CGFloat = 90 - 0.5
        numLabel.frame = CGRect(x: aNLX, y: aNLY, width: aNLW, height: aNLH)
        
        let aLVY: CGFloat = numLabel.frame.maxY - 0.5
        let aLVH: CGFloat = 0.5
        lineView.frame = CGRect(x: aNLX, y: aLVY, width: aNLW, height: aLVH)
    }
    
    /// 去后台
    @objc fileprivate func enterBack() {
        // 移除动画
        cursor.removeAnimation(forKey: "kOpacityAnimation")
    }
    
    /// 回前台
    @objc fileprivate func becomeActive() {
        // 重新添加动画
        cursor.add(opacityAnimation, forKey: "kOpacityAnimation")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- UI 创建
extension SVerifyCodeNumView {
    private func setupUIView() {
        
        numLabel.textAlignment = .center
        numLabel.font = UIFont.systemFont(ofSize: 17)
        numLabel.textColor = UIColor.black
        self.addSubview(numLabel)
        
        
        lineView.backgroundColor = UIColor.blue
        self.addSubview(lineView)
    }
}

// MARK:- 外部调用
extension SVerifyCodeNumView {
    /// 设置光标是否隐藏
    ///
    /// - Parameter isHidden: 是否隐藏
    open func setCursorStatus(_ isHidden: Bool) {
        if isHidden {
            cursor.removeAnimation(forKey: "kOpacityAnimation")
        }
        else {
            cursor.add(opacityAnimation, forKey: "kOpacityAnimation")
        }
        
        UIView.animate(withDuration: 0.25) {
            self.cursor.isHidden = isHidden
        }
    }
    
    /// 验证码赋值，并修改线条颜色
    ///
    /// - Parameter num: 验证码
    open func setNum(num: String?) {
        numLabel.text = num
    }
    
    /// 设置底部线条是否为焦点
    ///
    /// - Parameter isFocus: 是否是焦点
    open func setBottomLineFocus(isFocus: Bool) {
        if isFocus {
            lineView.backgroundColor = UIColor.blue
            
        } else {
            lineView.backgroundColor = UIColor.gray
        }
    }
    
    /// 获取当前的验证码
    ///
    /// - Returns: 验证码
    open func getNum() -> String {
        return numLabel.text ?? ""
    }
    
    /// 返回验证码值
    ///
    /// - Returns: 验证码数值
    open func getNum() -> String? {
        return numLabel.text
    }
}
