//
//  MovieListLinkViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit
import WebKit

class MovieListLinkViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var webKitView: WKWebView!
    
    var movieLink: String?
    var movieTitle: String?
    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkSetting()
    }
    
    func linkSetting() {
        lblTitle.text = movieTitle
        networkCheck() { [self] in
            webKitView.scrollView.bounces = false
            if let address = movieLink {
                let url = URL(string: address)
                let urlRequest = URLRequest(url: url!)
                webKitView.load(urlRequest)
            }
        }
    }
}
