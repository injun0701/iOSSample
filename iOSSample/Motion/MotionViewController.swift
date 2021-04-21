//
//  MotionViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class MotionViewController: UIViewController {

    @IBOutlet var lblMotion: UILabel!
    @IBAction func btnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //뷰 컨트롤러가 FirstResponder가 될 수 있도록 해주는 프로퍼티 재정의
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //뷰 컨트롤러가 FirstResponder가 되도록 설정
        self.becomeFirstResponder()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        lblMotion.text = "흔들기 시작"
        NSLog("흔들기 시작")
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //1초 딜레이 후 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.lblMotion.text = "스마트폰을 흔들어 보세요!"
        }
    }
}
