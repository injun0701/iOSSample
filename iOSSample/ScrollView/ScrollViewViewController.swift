//
//  ScrollViewViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/22.
//

import UIKit

class ScrollViewViewController: UIViewController {
    
    @IBAction func btnToImgScrollAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "ScrollView", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ImgScrollViewViewController") as! ImgScrollViewViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    @IBAction func btnToImgSwipeAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "ScrollView", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ImgSwipeViewController") as! ImgSwipeViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
