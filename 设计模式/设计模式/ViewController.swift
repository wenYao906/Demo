//
//  ViewController.swift
//  设计模式
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeaponUserNoneFactory()
    }
}


extension ViewController {
    
    /// 没有使用工厂模式
    private func getWeaponUserNoneFactory() {
        let weaponUser: WeaponUser = WeaponUser()
        
        weaponUser.fireWithType(weaponType: .AK)
        weaponUser.fireWithType(weaponType: .AWP)
    }
}
