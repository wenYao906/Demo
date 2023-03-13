//
//  BaseWebViewController.swift
//  Demo
//
//  Created by study on 2023/3/10.
//

import UIKit
import WebKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

class BaseWebViewController: UIViewController {
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
//        createWebView(withFrame: self.view.frame)
        
        view.addSubview(webView)
        view.addSubview(myProgressView)
        settingProgress()
        setupNavigationItem()
        

        
        if let resourceUrl = URL(string: urlString ?? "") {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)
        }
    }
    
    private func createWebView(withFrame frame:CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self;
        webView.navigationDelegate = self;
        webView.allowsBackForwardNavigationGestures = true // 允许左滑返回
        
        if let resourceUrl = URL(string: urlString ?? "") {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)
            return webView
        }
        
        return nil
    }
    
    
    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), configuration: addConfig())
        view.uiDelegate = self // UI代理
        view.navigationDelegate = self // 导航代理
        view.allowsBackForwardNavigationGestures = true // 允许左滑返回
        
        let backlist: WKBackForwardList = view.backForwardList // 存储已经打开过的网页（栈数据结构）
        view.goBack() // 页面后退
        view.goForward() // 页面前进
        view.reload() // 刷新
        
        return view
    }()
    
    private lazy var myProgressView: UIProgressView = {
        let view = UIProgressView(frame: CGRect(x: 0, y: 64+2, width: SCREEN_WIDTH, height: 2))
        view.tintColor = .blue
        view.trackTintColor = .red
        
        return view
    }()
    
    deinit {
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "getJSFuncNoParams")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "getJSFuncWithParams")
        
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
        
        print("webView释放")
    }
}

@objc extension BaseWebViewController {
    func goBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadHtml() {
        print("loadHtml")
        
        guard let path = Bundle.main.path(forResource: "JStoOC", ofType: "html") else {
            print("failed--1")
            return
        }
        guard let htmlString = try? String(contentsOfFile: path, encoding: .utf8) else {
            print("failed--2")
            return
        }
        webView.loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: Bundle.main.bundlePath))
    }
    
    func refreshAction() {
        print("refreshAction")
        webView.reload()
    }
    
    func ocToJS() {
        let jsString = String(format: "changeColor('%@')", "JS颜色参数")
        webView.evaluateJavaScript(jsString) { _, _ in
            print("颜色改变")
        }
        
//        let jsFont0 = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '50%'" // 固定字体为50
        let jsFont = String(format: "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", (arc4random()%99 + 100))
        webView.evaluateJavaScript(jsFont, completionHandler: nil)
    }

}

private extension BaseWebViewController {
    func setupNavigationItem() {
        let goBackBtn = UIButton(type: .custom)
        goBackBtn.setImage(UIImage(named: "backbutton"), for: .normal)
        goBackBtn.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        goBackBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 64)
        
        let goBackItem = UIBarButtonItem(customView: goBackBtn)
        let jstoOCItem = UIBarButtonItem(title: "首页", style: .done, target: self, action: #selector(loadHtml))
        
        self.navigationItem.leftBarButtonItems = [goBackItem, jstoOCItem]
        
        let refreshBtn = UIButton(type: .custom)
        refreshBtn.setImage(UIImage(named: "webRefreshButton"), for: .normal)
        refreshBtn.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
        
        let refreshItem = UIBarButtonItem(customView: refreshBtn)
        let ocToJSItem = UIBarButtonItem(title: "OC调用JS", style: .done, target: self, action: #selector(ocToJS))
        self.navigationItem.rightBarButtonItems = [refreshItem, ocToJSItem]
        
        self.navigationController?.navigationBar.isTranslucent = true // 是否半透明
    }
    
    func addConfig() -> WKWebViewConfiguration {
        // 网页配置对象
        let config = WKWebViewConfiguration()
        
        // 配置对象的偏好设置
        let preference = WKPreferences()
//        preference.minimumFontSize = 15 // 最小字体
        preference.javaScriptEnabled = true // 支持JavaScript
        preference.javaScriptCanOpenWindowsAutomatically = true // javaScript可以打开窗口
        
        config.preferences = preference
        config.allowsInlineMediaPlayback = true // 允许使用在线播放
        config.allowsPictureInPictureMediaPlayback = true // 画中画
        config.applicationNameForUserAgent = "ChinaDailyForiPad" // User-Agent
        
        config.userContentController = setWKUserContentController()
        
        return config
    }
    
    func setWKUserContentController() -> WKUserContentController {
        // WKUserContentController: 主要用来做native与js的交互管理
        
        let scriptMessageHandler = WeakScriptMessage(self)
        let userContent = WKUserContentController()
        
        // 监听JS方法 -- getJSFuncNoParams
        userContent.add(scriptMessageHandler, name: "jsToOcNoPrams")
        // 监听JS方法 -- getJSFuncWithParams
        userContent.add(scriptMessageHandler, name: "jsToOcWithPrams")
        
        userContent.addUserScript(setUserScript()) // 添加js注入
        
        return userContent
    }
    
    func setUserScript() -> WKUserScript {
        let jsString = """
        var meta = document.createElement('meta');
        meta.setAttribute('name', 'viewport');
        meta.setAttribute('content', 'width=device-width');
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        
        let wkUScript = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        return wkUScript
    }
    
    
}

private extension BaseWebViewController {
    func changeColor() {
        let jsString = "changeColor('Js参数')"
        webView.evaluateJavaScript(jsString) { _, _ in
            print("改变HTML颜色背景")
        }
        
        let jsFont = """
        document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '(arc4random()%99 + 100)%%,
        """
        webView.evaluateJavaScript(jsFont) { _, _ in
            print("改变jsFont")
        }
    }
    
    func getCookie() {
        print("getCookie")
        let cookieStorage = HTTPCookieStorage.shared
        var JSFuncString = """
            function setCookie(name,value,expires)
            {
            var oDate=new Date();
            oDate.setDate(oDate.getDate()+expires);
            document.cookie=name+'='+value+';expires='+oDate+';path=/'
            }
            function getCookie(name)
            {
            var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));
            if(arr != null) return unescape(arr[2]); return null;
            }
            function delCookie(name)
            {
            var exp = new Date();
            exp.setTime(exp.getTime() - 1);
            var cval=getCookie(name);
            if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();
            }
        """
        
        guard let cookieArr = cookieStorage.cookies else {
            return
        }
        for cookie in cookieArr {
            let tempStr = String(format: "setCookie('%@', '%@', 1)", arguments: [cookie.name, cookie.value])
            JSFuncString += tempStr
            print("JSFuncString--\(JSFuncString)")
        }
        
        webView.evaluateJavaScript(JSFuncString) { _, _ in
            print("执行cookie")
        }
    }
}

extension BaseWebViewController {
    private func settingProgress() {
        self.webView.addObserver(self,
                                 forKeyPath: "estimatedProgress",
                                 options: .new,
                                 context: nil)
        
        self.webView.addObserver(self,
                                 forKeyPath: "title",
                                 options: .new,
                                 context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("网页加载进度---\(webView.estimatedProgress)")
        if keyPath == "estimatedProgress" {
            let viewProgress = Float(self.webView.estimatedProgress)
            self.myProgressView.progress = viewProgress
            if viewProgress >= 1.0 {
                DispatchQueue.main.async {
                    self.myProgressView.progress = 0
                }
            }
        } else if keyPath == "title" {
            self.navigationItem.title = webView.title
        }
    }
}


// TODO:- 主要处理JS脚本，确认框，警告等
/// 主要处理JS脚本，确认框，警告等
extension BaseWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("弹窗。。。警告窗")
        let alertController = UIAlertController(title: "HTML的弹框", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        }
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("弹窗。。。确认窗")
        
        let alertController = UIAlertController(title: "请确认", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(false)
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler(true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("弹框。。。输入框")
        
        let alertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        alertController.addTextField { textF in
            textF.placeholder = defaultText
        }
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler(alertController.textFields?.first?.text)
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("页面弹窗。。。是_blank处理")
        if !(navigationAction.targetFrame?.isMainFrame ?? true) {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}

// TODO:-  主要处理一些跳转，加载处理操作
/// 主要处理一些跳转，加载处理操作
extension BaseWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("页面开始加载。。。")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("页面加载失败。。。")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("当内容开始返回时。。。")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("页面加载完成。。。")
        self.getCookie()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("提交发生错误。。。")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("接收到服务器跳转请求重定向。。。")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("根据即将跳转的HTTP请求头信息和相关信息来决定是否跳转。。。")
        decisionHandler(WKNavigationActionPolicy.allow)
        let headStr = "github://"
        if let urlStr = navigationAction.request.url?.absoluteString {
            if urlStr.hasPrefix(headStr) {
                let alertController = UIAlertController(title: "通过截取URL调用OC", message: "前往GitHub？", preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let actionOK = UIAlertAction(title: "打开", style: .default, handler: { action in
                    let url = "https://github.com/"
                    UIApplication.shared.open(URL(string: url)!)
                })
                
                alertController.addAction(actionCancel)
                alertController.addAction(actionOK)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    /**
     这个必须要实现响应方法，否则点击链接就会crash
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("根据客户端接收到的服务器响应头以及response相关信息来决定是否可以跳转。。。")
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("需要响应身份验证时调用，在闭包中传入用户身份凭证。。。")
        
        // 当前身份信息
        let curCred = URLCredential(user: "张三", password: "123", persistence: .none)
        // 给challenge的发送者提供身份信息
        challenge.sender?.use(curCred, for: challenge)
        // 回调信息
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, curCred)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("当进程被终止时调用。。。")
    }
    
}

// TODO:- 处理js传递的消息
extension BaseWebViewController: WKScriptMessageHandler {
    
    /**
     处理js传递的消息
     */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("接受到JS传递的消息：\(message.name)")
        if message.name == "jsToOcNoPrams" {
            let alertController = UIAlertController(title: "JS调用OC", message: "不带参数", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                print("点击了ok")
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
                print("弹出框了")
            }
        }
        
        if message.name == "jsToOcWithPrams" {
            let dict: NSDictionary = message.body as! NSDictionary
            let value = dict["params"]
            let alertController = UIAlertController(title: "JS调用OC", message: "带参数:\(value)", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                print("点击了ok")
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
                print("弹出框了")
            }
        }
    }
}

