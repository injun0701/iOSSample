//
//  UIObjectViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class UIObjectViewController: UIViewController {
    
    @IBAction func btnToLbl(_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "LblViewController") as! LblViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToBtn
    (_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "BtnViewController") as! BtnViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
