//
//  UIObjectViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class UIObjectViewController: UIViewController {
    
    @IBAction func btnToLblAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "LblViewController") as! LblViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToBtnAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "BtnViewController") as! BtnViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToImgAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ImgViewViewController") as! ImgViewViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToPickerViewAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "PickerViewViewController") as! PickerViewViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
