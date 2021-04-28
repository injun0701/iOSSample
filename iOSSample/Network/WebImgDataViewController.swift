//
//  WebImgDataViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/28.
//

import UIKit

class WebImgDataViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //네트워크 사용 여부 확인
        let reachability = Reachability()
        let result = reachability.isConnectedToNetwork()
        
        if result == true {
            WebImgDownload()
            WebTextDownload()
        } else {
            textView.text = "네트워크를 연결해주세요."
        }
    }
    
    //웹에서 이미지 다운
    func WebImgDownload() {
        //다운로드 받을 URL을 생성
        let imgAddr = "https://www.theguru.co.kr/data/photos/20200939/art_16010170499851_38273e.jpg"
        let imgUrl = URL(string: imgAddr)
        //동기적으로 다운로드 받기
        //Data는 예외 처리를 반드시 해야 하는 함수라서 try!으로 예외가 발생하지 않는다고 설정
        let imgData = try! Data(contentsOf: imgUrl!)
        //다운로드 받은 데이터를 이미지로 변환
        let image = UIImage(data: imgData)
        //이미지 뷰에 출력
        imgView.image = image
    }
    
    func WebTextDownload() {
        let textAddr = "https://www.naver.com"
        let textURL = URL(string: textAddr)
        //문자열 다운로드
        let textData = try! Data(contentsOf: textURL!)
        //다운로드 받은 데이터를 문자열로 변환
        let text = String(data: textData, encoding: .utf8)
        //텍스트뷰에 출력
        textView.text = text
    }
    
    
}
