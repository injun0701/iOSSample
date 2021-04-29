//
//  AlamofireViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네트워크 사용 여부 확인
        networkCheck() { [self] in
            imgDownload()
            textDownload()
        }
    }
    
    func imgDownload() {
        //이미지 다운로드
        let request = AF.request("https://raw.githubusercontent.com/Alamofire/Alamofire/master/alamofire.png", method: .get, parameters: nil)
        request.response {
            request in
            
            let img = UIImage(data: request.data!)
            self.imgView.image = img
        }
    }
    
    func textDownload() {
        //문자열 다운로드
        let request = AF.request("https://github.com/Alamofire/Alamofire", method: .get, parameters: nil)
        request.response {
            request in
            
            let msg = String(data: request.data!, encoding: .utf8)
            NSLog(msg!)
            self.textView.text = msg
        }
        
    }
}
