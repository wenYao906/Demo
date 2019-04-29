//
//  SAgreementWebViewController.swift
//  SoulDemo
//
//  Created by study on 2019/4/15.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// Soul 用户协议
class SAgreementWebViewController: UIViewController {

    private let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        webView.scrollView.bounces = false
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        
        let path = Bundle.main.bundlePath
        let url = URL.init(fileURLWithPath: path)
        let htmlPath = Bundle.main.path(forResource:"SUserAgreement", ofType:"html")
        let htmlContent = try!String.init(contentsOfFile: htmlPath!)
        webView.loadHTMLString(htmlContent, baseURL: url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 显示导航栏
        self.navigationController?.navigationBar.isHidden = false
    }
}
/*
 NSString * requestString = [[request URL] absoluteString];
 requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
 if ([requestString hasPrefix:@"goback:"]) {
 [self.navigationController popViewControllerAnimated:YES];
 }else{
 [self.webView goBack];
 }
 return YES;
 
 */

extension SAgreementWebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let requestString = request.url?.absoluteString
        //核心代码
        // agreementBtn 是 是 HTMl 中 按钮的方法里面的重定向文字
        if requestString!.hasSuffix("agreementBtn"){

            // 向h5传递参数
//            webView.stringByEvaluatingJavaScript(from: "sendDataToWeb(\(id) , \(tocken))")
            // 从h5接收参数
            
            // changeInfo() 是 HTMl 中 按钮的方法名称
            let returnStr = webView.stringByEvaluatingJavaScript(from: "changeInfo()")
            webView.stopLoading()
            
            self.navigationController?.popViewController(animated: true)
        }
        
        /// 不同意
        if requestString!.hasSuffix("noAgreementBtn"){
            // changeInfo() 是 HTMl 中 按钮的方法名称
            let returnStr = webView.stringByEvaluatingJavaScript(from: "noAgreementBtnInfo()")
            webView.stopLoading()
            
            
            self.navigationController?.popViewController(animated: true)
        }
        
        return true
    }
}
