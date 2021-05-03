//
//  Extension.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit

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
