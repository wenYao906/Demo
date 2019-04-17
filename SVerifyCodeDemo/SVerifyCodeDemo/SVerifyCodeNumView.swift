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
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
        return label
    }()
    
    /// 下划线
    private lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.blue
        self.addSubview(line)
        return line
    }()
    
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
        
        let aNLX: CGFloat = frame.origin.x
        let aNLY: CGFloat = frame.origin.y
        let aNLW: CGFloat = frame.size.width
        let aNLH: CGFloat = frame.size.height - 0.5
        numLabel.frame = CGRect(x: aNLX, y: aNLY, width: aNLW, height: aNLH)
        
        let aLVY: CGFloat = numLabel.frame.maxY
        let aLVH: CGFloat = 0.5
        lineView.frame = CGRect(x: aNLX, y: aLVY, width: aNLW, height: aLVH)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 外部调用
extension SVerifyCodeNumView {
    
}
