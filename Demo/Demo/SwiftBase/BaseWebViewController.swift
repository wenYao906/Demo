//
//  BaseWebViewController.swift
//  Demo
//
//  Created by study on 2023/3/10.
//

import UIKit
import WebKit

class BaseWebViewController: UIViewController {
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        createWebView(withFrame: self.view.frame)
    }
    
    private func createWebView(withFrame frame:CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let resourceUrl = URL(string: urlString ?? "") {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)
            return webView
        }
        
        return nil
    }
}
