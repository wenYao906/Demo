//
//  SAgreementController.swift
//  SoulDemo
//
//  Created by study on 2019/4/15.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class SAgreementController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView()
        webView.scrollView.bounces = false
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        
        let path = Bundle.main.bundlePath
        let url = URL.init(fileURLWithPath: path)
        let htmlPath = Bundle.main.path(forResource:"SUserAgreement", ofType:"html")
        let htmlContent = try!String.init(contentsOfFile: htmlPath!)
        webView.loadHTMLString(htmlContent, baseURL: url)
    }
}
