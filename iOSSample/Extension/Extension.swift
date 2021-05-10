//
//  Extension.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit
import CoreLocation

extension UIViewController {
    
    //네트워크 체크
    func networkCheck(after: @escaping () -> ()) {
        //네트워크 사용 여부 확인
        let reachability = Reachability()
        let result = reachability.isConnectedToNetwork()
        
        if result == true {
            after()
        } else {
            showAlertBtn1(title: "네트워크 오류", message: "네트워크를 키고 다시 실행해주세요.", btnTitle: "확인") {}
        }
        
    }
    
    //버튼 한개 알럿
    func showAlertBtn1(title: String, message: String, btnTitle: String, action: @escaping () -> Void)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn1 = UIAlertAction(title: btnTitle, style: .default) { (_) in
            print("버튼1 클릭함")
            action()
        }
        alert.addAction(btn1)
        
        present(alert, animated: true) {
            print("Alert이 잘 작동됨")
        }
    }
    
    //버튼 두개 알럿
    func showAlertBtn2(title: String, message: String, btn1Title: String, btn2Title: String, btn1Action: @escaping () -> Void, btn2Action: @escaping () -> Void)  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn1 = UIAlertAction(title: btn1Title, style: .default) { (_) in
            print("버튼1 클릭함")
            btn1Action()
        }
        alert.addAction(btn1)
        
        let btn2 = UIAlertAction(title: btn2Title, style: .default) { (_) in
            print("버튼2 클릭함")
            btn2Action()
        }
        alert.addAction(btn2)
        
        present(alert, animated: true) {
            print("Alert이 잘 작동됨")
        }
    }
    
  
    
    //위치 권한 체크
    @objc func locationCheck(after: @escaping () -> ()) {
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted {
            let alter = UIAlertController(title: "위치 권한 설정이 '허용 안 함'으로 되어있습니다.", message: "앱 설정 화면으로 가시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            let logOkAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default){
                (action: UIAlertAction) in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
                } else {
                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                }
                after()
            }
            let logNoAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.destructive){
                (action: UIAlertAction) in
                after()
            }
            alter.addAction(logNoAction)
            alter.addAction(logOkAction)
            self.present(alter, animated: true, completion: nil)
        }
    }
}

//MARK: 네비게이션컨트롤러 extension
extension UINavigationController {
    
    //이전 스텍 체크하는 함수
    func previousViewController() -> UIViewController?{
        
        let lenght = self.viewControllers.count
        
        let previousViewController: UIViewController? = lenght >= 2 ? self.viewControllers[lenght-2] : nil
        
        return previousViewController
    }
    
}
