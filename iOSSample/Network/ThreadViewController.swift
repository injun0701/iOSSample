//
//  ThreadViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit

class ThreadViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네트워크 사용 여부 확인
        networkCheck() {
            //스레드 객체 생성
            let thread = ThreadDownloader()
            thread.imgView = self.imgView
            thread.textView = self.textView
            //스레드를 시작
            thread.start()
        }
    }
    
}
