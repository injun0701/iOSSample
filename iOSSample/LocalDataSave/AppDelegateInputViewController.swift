//
//  AppDelegateInputViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit

class AppDelegateInputViewController: UIViewController {

    @IBOutlet var tfAppDelegateSave: UITextField!
    @IBOutlet var tfUserDefaultsSave: UITextField!
    
    @IBAction func btnDataSaveAction(_ sender: UIButton) {
        if tfAppDelegateSave.text == "" || tfUserDefaultsSave.text == ""  {
            showAlertBtn1(title: "입력 오류", message: "입력란을 모두 작성해주세요.", btnTitle: "확인") {}
        } else {
            dataSave() 
        }
    }
    
    //데이터 저장 메소드
    func dataSave() {
        //입력한 문자열 가져오기
        let name = tfAppDelegateSave.text
        let email = tfUserDefaultsSave.text
        
        //AppDelegate에 저장
        let appDelagte = UIApplication.shared.delegate as! AppDelegate
        appDelagte.name = name!
        
        //환경 설정에 저장
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "email")
        
        //자신을 출력한 뷰 컨트롤러로 이동
        let vc = presentingViewController as! AppDelegateViewController
        vc.dismiss(animated: true) {
            //출력하는 함수를 호출
            vc.display()
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
