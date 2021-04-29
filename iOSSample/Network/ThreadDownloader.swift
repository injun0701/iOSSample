//
//  ThreadDownloader.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit

class ThreadDownloader: Thread {
    //출력을 위한 뷰 프로퍼티
    var imgView : UIImageView!
    var textView : UITextView!
    
    //스레드로 동작할 메소드
    override func main() {
        
        OperationQueue.main.addOperation {
            //다운로드 받을 URL을 생성
            let textAddr = "https://www.naver.com"
            let textURL = URL(string: textAddr)
            //문자열 다운로드
            let textData = try! Data(contentsOf: textURL!)
            //다운로드 받은 데이터를 문자열로 변환
            let text = String(data: textData, encoding: .utf8)
            //텍스트뷰에 출력
            self.textView.text = text
            
            //다운로드 받을 URL을 생성
            let imgAddr = "https://www.navercorp.com/img/ko/mobile/naver/img_intro.png"
            let imgUrl = URL(string: imgAddr)
            //Data는 예외 처리를 반드시 해야 하는 함수라서 try!으로 예외가 발생하지 않는다고 설정
            let imgData = try! Data(contentsOf: imgUrl!)
            //다운로드 받은 데이터를 이미지로 변환
            let image = UIImage(data: imgData)
            //이미지 뷰에 출력
            self.imgView.image = image
        }
        
    }
}
