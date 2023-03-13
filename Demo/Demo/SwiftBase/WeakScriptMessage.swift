//
//  WeakScriptMessage.swift
//  Demo
//
//  Created by study on 2023/3/13.
//

import UIKit
import WebKit

class WeakScriptMessage: NSObject {
    weak var scriptMesHandler: WKScriptMessageHandler?
    
    init(_ handler: WKScriptMessageHandler) {
        super.init()
        self.scriptMesHandler = handler
    }
    
    deinit {
        print("deinit--WeakScriptMessage")
    }
}

extension WeakScriptMessage: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.scriptMesHandler?.userContentController(userContentController, didReceive: message)
    }
}


