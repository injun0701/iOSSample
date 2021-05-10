//
//  AES256ViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/09.
//

import UIKit

class AES256ViewController: UIViewController {
    @IBOutlet weak var tfDecryped: UITextField!
    @IBOutlet weak var lblEncryped: UILabel!
    @IBOutlet weak var tfEncryped: UITextField!
    @IBOutlet weak var lblDecryped: UILabel!

    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    let defaultKey : String = "abcdefghijklmnopqrstuvwxyz123456" // default key 32
    //Default iv는 0123456789101112
    //AES.swift 파일에서 iv 확인 가능
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //암호화하기 버튼
    @IBAction func btnEncryped(_ sender: UIButton) {
       
        //유효성 검사
        validation(tf: tfDecryped, msg: "암호화 입력란를 작성해 주세요") { [self] in
            //AES.swift에 있는 기능 이용, 사용자가 입력한 텍스트를 암호화한다.
            lblEncryped.text = AES256CBC.encryptString(tfDecryped.text!, password: defaultKey)!
        }
        
    }
    
    //암호화풀기 버튼
    @IBAction func btnDecryped(_ sender: UIButton) {
        
        //유효성 검사
        validation(tf: tfEncryped, msg: "복호화 입력란를 작성해 주세요") { [self] in
            //AES.swift에 있는 기능 이용, 사용자가 입력한 텍스트를 복호화한다.
            lblDecryped.text = AES256CBC.decryptString(tfEncryped.text!, password: defaultKey)!
        }
        
    }
    
    //유효성 검사
    func validation(tf: UITextField, msg: String, next: @escaping () -> () ) {
        if tf.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlertBtn1(title: "입력 오류", message: msg, btnTitle: "확인") {}
        } else {
            next()
        }
    }
    
    //lblEncryped를 클립보드에 복사
    @IBAction func btnLblEncrypedCopyAction(_ sender: UIButton) {
        UIPasteboard.general.string = lblEncryped.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
