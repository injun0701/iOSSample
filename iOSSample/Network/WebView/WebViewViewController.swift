//
//  WebViewViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/27.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    @IBOutlet var webKitView: WKWebView!
    
    var webAddress : String!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkSetting() 
    }
    
    func linkSetting() {
        networkCheck() { [self] in
            webAddress = "https://www.naver.com"
            webKitView.scrollView.bounces = false
            if let address = webAddress {
                let url = URL(string: address)
                let urlRequest = URLRequest(url: url!)
                webKitView.load(urlRequest)
            }
        }
    }
    
}
