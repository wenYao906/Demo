//
//  WYCircleLoadAnimationView.swift
//  SoulDemo
//
//  Created by study on 2019/4/11.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

enum typeLocation {
    case typeLeft // 左边实线
    case typeRight // 右边实线
}

/// 画 渐变线（默认颜色为黑色渐变成白色透明）
class WYCircleLoadAnimationView: UIView {
    
    init(frame: CGRect, type: typeLocation) {
        super.init(frame: frame)
        
        let colors = setupCGColor(type: type)
        setupView(frame: frame, color: colors)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WYCircleLoadAnimationView {
    private func setupView(frame: CGRect, color: [CGColor]?) {
        let aColors = color
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = aColors
        gradientLayer.locations = gradientLocations
        
        // 左边实线到右边白色透明
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint =  CGPoint(x: 1.0, y: 0)
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame.size = frame.size
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupCGColor(type: typeLocation) -> [CGColor]{
        // 黑色
        let topColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)

        // 白色
        let buttomColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0)
        
        var gradientColors: [CGColor]?
        
        print("type = \(type)")
        
        if type == typeLocation.typeLeft {  // 左侧 
            // 黑色 - 白色
            gradientColors = [topColor.cgColor, buttomColor.cgColor]
            
        } else { // 右侧
            // 白色 - 黑色
            gradientColors = [buttomColor.cgColor, topColor.cgColor]
        }
        
        return gradientColors!
    }
}
