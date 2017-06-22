//: Playground - noun: a place where people can play

import UIKit

/*
 
 把需要被重写的方法 声明在  协议中的声明中  是一种刻意的做法。
 我们希望该方法被重写，回到架构上，getData负责不同的view处理获得的Model，
 View的类型非常多，所以getData的格式无法统一到一个默认的方法实现中，
 我们需要getData被具体的View所从写，
 为了强制这种意图，getData甚至没有一个默认的实现方法体。
 
 根据Swift的协议规则，协议遵守者需要实现协议中的所有方法，
 所以getData一定会有具体声明。
 
 
 */


protocol SharedString {
    func methodForOverride()
}

extension SharedString {
    func methodForOverride() {
        print("(｡•ˇ‸ˇ•｡)")
    }
    
    func methodWithoutOverride() {
        print("--------------")
        
        methodForOverride()
        
        print("--------------")
    }
}

extension String: SharedString {
    func methodForOverride() {
        print(self)
    }
}

//"hello".methodForOverride()
let hello: SharedString = "hello"
//hello.methodForOverride()

"hello".methodWithoutOverride()
hello.methodWithoutOverride()