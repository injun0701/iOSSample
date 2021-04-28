//
//  NetworkViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/28.
//

import UIKit

class NetworkViewController: UIViewController {
    
    @IBAction func btnToWebImgDataAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Network", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "WebImgDataViewController") as! WebImgDataViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    
    @IBAction func btnToXmlParsingAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Network", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "XmlParsingViewController") as! XmlParsingViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
