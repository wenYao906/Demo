//
//  WeaponUser.swift
//  设计模式
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import Foundation

class WeaponUser {
    func fireWithType(weaponType: WeaponTypeEnumeration) {
        var weapon: WeaponType
        
        switch weaponType {
        case .AK:
            weapon = AK()
        case .HK:
            weapon = HK()
        case .AWP:
            weapon = AWP()
        }
        
        print(weapon.fire())
    }
}
