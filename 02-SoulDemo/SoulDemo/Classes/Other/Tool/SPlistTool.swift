//
//  SPlistTool.swift
//  SoulDemo
//
//  Created by study on 2019/4/12.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class SPlistTool: NSObject {
    class func  plistWithAreaCode() -> NSArray {
        // 生成文件的存储路径
        let diaryList: String = Bundle.main.path(forResource: "areaCodes", ofType:"plist")!
        //读取属性列表文件，并转化为可变字典对象
        let data: NSArray = NSArray(contentsOfFile:diaryList) ?? []
//        let diaries: NSArray = data[0] as! NSArray
        
        return data
    }
}
