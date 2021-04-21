//
//  BtnViewController1.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class BtnViewController: UIViewController {
    
    @IBOutlet var btnSample: UIButton!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var lblEmailResult: UILabel!
    @IBOutlet var btnEmail: UIButton!
    
    @IBOutlet var btnBackView: SubViewBackgroundDesignBtn!
    
    @IBOutlet var btnBackViewBottom: NSLayoutConstraint!
    
    @IBAction func btnEmailAction(_ sender: UIButton) {
        //결과값에 출력
        lblEmailResult.text = tfEmail.text
        //초기화
        tfEmail.text = ""
        
        //키보드 제거
        tfEmail.resignFirstResponder()
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnViewControllerSetting()
        notificationSetting()
    }
    
    func btnViewControllerSetting() {
        //리소스 추가한 이미지를 객체로 생성
        let btnImgNormal = UIImage(named: "btn_01.png")
        let btnImgHighlighted = UIImage(named: "btn_02.png")
        
        btnSample.setBackgroundImage(btnImgNormal, for: .normal)
        btnSample.setBackgroundImage(btnImgHighlighted, for: .highlighted)
        
        btnSample.setTitle("눌러보세요.", for: .normal)
        btnSample.setTitle("누르고 있어요!", for: .highlighted)
        
        //보더
        btnEmail.layer.borderWidth = 1.0
        btnEmail.layer.cornerRadius = 6
        btnEmail.layer.borderColor = UIColor(displayP3Red: 0/255, green: 113/255, blue: 255/255, alpha: 1).cgColor
        
        //시작하자마자 tfEmail 입력 키보드 올라오도록 설정
        tfEmail.becomeFirstResponder()
        
        //delegate 설정
        //tfEmail에서 이벤트가 발생하면 이벤트 처리 메소드르르 self에서 찾음
        tfEmail.delegate = self
        
    }
    
    
    func notificationSetting() {
        //노티피케이션과 함수 연결
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //노티피케이션과 클로져 연결
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) -> Void in
            
            //이전버튼 원위치로 이동 애니메이션
            UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
                
                self.btnBackViewBottom.constant = 10
                self.view.layoutIfNeeded()
                
            }.startAnimation()
            
        }
    }
    
    //키보드가 올라올 때 호출하는 함수
    @objc func keyboardWillShow(notification:Notification) -> Void {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary;
        let keyboardFrame:NSValue = userInfo.value(forKey:UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue;
        let keyboardHeight = keyboardRectangle.size.height;
        
        //이전버튼 원위치
        btnBackViewBottom.constant = 10
        //이전버튼 키보드 위로 이동 애니메이션
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            
            self.btnBackViewBottom.constant = keyboardHeight
            self.view.layoutIfNeeded()
            
        }.startAnimation()
        
    }

    //터치가 발생할 때 호출되는 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //키보드 제거
        tfEmail.resignFirstResponder()
    }
    
    
}

extension BtnViewController : UITextFieldDelegate {
    //UITextFieldDelegate의 키보드에 Return버튼을 누르면 호출되는 메소드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail {
            //결과값에 출력
            lblEmailResult.text = tfEmail.text
            //초기화
            tfEmail.text = ""
        }
        //키보드 제거
        tfEmail.resignFirstResponder()
        return true
    }
}
