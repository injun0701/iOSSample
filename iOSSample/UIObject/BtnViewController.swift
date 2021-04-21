//
//  BtnViewController1.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class BtnViewController: UIViewController {
    
    @IBOutlet var btnSample: UIButton!
    
    @IBAction func btnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSetting() 
    }
    
    func btnSetting() {
        //리소스 추가한 이미지를 객체로 생성
        let btnImgNormal = UIImage(named: "btn_01.png")
        let btnImgHighlighted = UIImage(named: "btn_01.png")
        
        btnSample.setBackgroundImage(btnImgNormal, for: .normal)
        btnSample.setBackgroundImage(btnImgHighlighted, for: .highlighted)
        
        btnSample.setTitle("보통", for: .normal)
        btnSample.setTitle("누르고 있음", for: .highlighted)
        
    }

}
