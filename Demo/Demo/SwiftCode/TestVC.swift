//
//  TestVC.swift
//  Demo
//
//  Created by study on 2023/3/28.
//

import UIKit

class TestVC {

    init(squre: Double) {
        self.squre = squre
    }
    var squre: Double {
        willSet {
            print("willSet方法被调用")
            print("在willSet中，width = \(squre),newValue = \(newValue)")
        }
        
        didSet {
            print("didSet方法被调用")
            print("在didSet中，width = \(squre),oldValue = \(oldValue)")
        }
    }
}
