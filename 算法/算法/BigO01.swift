//
//  BigO01.swift
//  算法
//
//  Created by study on 2019/5/3.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 01-大O表示法
class BigO01: NSObject {

    /// 估算方法的复杂度
    public func test1(n: Int) {
        if n > 10 {
            print("n > 10")
        } else if n > 5 {
            print("n > 5")
        } else {
            print("n <= 5")
        }
        
        for _ in 0..<4 {
            print("test")
        }
    }
    
    public func test3 (n: Int) {
        for i in 0..<n {
            for j in 0..<n {
                print("test - \(i) \(j)")
            }
        }
    }
    
    public func fib2(n: Int) -> Int {
        if (n <= 1){
            return n;
        }
        
        var first: Int = 0;
        var second: Int = 1;

        for _ in 0..<n-1 {
            let sum: Int = first + second;
            first = second;
            second = sum;
        }
        return second;
    }
}
