//
//  ViewController.swift
//  算法
//
//  Created by study on 2019/5/3.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let big = BigO01()
        let aBig = big.fib2(n: 7)
        
        print("aBig = \(aBig)")
    }
}

