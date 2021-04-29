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
            //대화상자로 출력하기
            let alert = UIAlertController(title: "네트워크 오류", message: "네트워크를 키고 다시 실행해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
                            
            self.present(alert, animated: true)
        }
        
    }

}
