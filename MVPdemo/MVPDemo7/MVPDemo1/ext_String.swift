//
//  ext_String.swift
//  MVPDemo1
//
//  Created by study on 2017/6/22.
//  Copyright © 2017年 WY. All rights reserved.
//

import UIKit

extension String: SharedString {

    func methodForOverride() {
        print(self)
    }
}
