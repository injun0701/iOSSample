//
//  AppDelegateViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit

class AppDelegateViewController: UIViewController {

    @IBOutlet var lblAppDelegate: UILabel!
    @IBOutlet var lblUserDefaults: UILabel!
    
    @IBAction func toInputVC(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AppDelegateInputViewController") as! AppDelegateInputViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        display()
    }
    
    func display() {
        //AppDelegate의 name 프로퍼티의 값을 lblAppDelegate에 출력
        if let name = (UIApplication.shared.delegate as! AppDelegate).name {
            lblAppDelegate.text = name
        }
        
        //UserDefaults의 email 프로퍼티의 값을 lblUserDefaults에 출력
        if let email = (UserDefaults.standard).string(forKey: "email") {
            lblUserDefaults.text = email
        }
        
        //AppDelegate 메모리 저장으로 앱을 다시 실행하면 초기화 되지만
        //UserDefaults 환경 설정 파일에 저장함으로 앱을 다시 실행해도 저장되어 있음(앱을 삭제하고 다시 깔아야 초기화)
        //UserDefaults는 데이터를 앱을 지우기 전까지 유지시켜서 사용할 수 있지만 작은 양의 데이터만 저장해서 사용할 것을 권장함
    }
    
}
