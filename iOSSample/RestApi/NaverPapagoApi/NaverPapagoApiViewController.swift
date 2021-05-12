//
//  NaverPapagoApiViewController.swift
//  SwiftSample
//
//  Created by HongInJun on 2021/04/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

class NaverPapagoApiViewController: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tfBefore: UITextView!
    @IBOutlet var tfAfter: UITextView!
    
    @IBOutlet var btnLang1: UIButton!
    @IBOutlet var btnLang2: UIButton!
    
    var btnLang1Text = "한글"
    let LangKo = "ko"
    let LangEn = "en"
    
    //로딩 객체
    let hud = JGProgressHUD()
    
    @IBAction func btnLangSwitchAction(_ sender: UIButton) {
        if btnLang1Text == "한글" {
            btnLang1Text = "영어"
            btnLang1.setTitle(btnLang1Text, for: .normal)
            btnLang2.setTitle("한글", for: .normal)
            let tfBeforeText = tfBefore.text
            tfBefore.text = tfAfter.text
            tfAfter.text = tfBeforeText
        } else {
            btnLang1Text = "한글"
            btnLang1.setTitle(btnLang1Text, for: .normal)
            btnLang2.setTitle("영어", for: .normal)
            let tfAfterText = tfAfter.text
            tfAfter.text = tfBefore.text
            tfBefore.text = tfAfterText
        }
    }
    
    @IBAction func btnTransAction(_ sender: UIButton) {
        //키보드 내리기
        self.view.endEditing(true)
        //로딩 시작
        hud.show(in: self.view)
        
        lblTitle.text = "번역할 문장을 작성해주세요."
        //네트워크 사용 여부 확인
        networkCheck() { [self] in
            if btnLang1Text == "한글" {
                //한글에서 영어로 번역
                callRequest(lang1: LangKo, lang2: LangEn, msg: tfBefore.text)
                //로딩 중지
                hud.dismiss(afterDelay: 0.4)
            } else {
                //영어에서 한글로 번역
                callRequest(lang1: LangEn, lang2: LangKo, msg: tfBefore.text)
                //로딩 중지
                hud.dismiss(afterDelay: 0.4)
            }
        }
    }
    
    @IBAction func btnCopyAction(_ sender: UIButton) {
        //1. 텍스트뷰에 작성된 텍스트 복사
        UIPasteboard.general.string = tfAfter.text
        
        //2.UIPasteboard에 복사되어 있는 텍스트가 존재하는지 확인
        /*
        if let copyStr = UIPasteboard.general.string {
            //3.텍스트가 존재한다면
            tfBefore.text = copyStr
            //4.서버 통신
            callRequest(msg: copyStr)
        }
         */
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func callRequest(lang1 : String, lang2 : String, msg: String) {
        //1.인증키
        // - 쿼리스트링: get에서 사용 - 쉽고 간단하지만 유출되기 쉽다.
        // - 헤더: http 구조 중 헤더와 바디가 존재하는데 헤더에 인증키를 넣어 구현하거나 토큰을 넣어서 구현, 위의 방법보다는 안전함
        //  -인증키: 변하지 않음
        //  -토큰: 시간이 지나면 변함 - 개개인 다른 토근을 가지고, 그 토큰으로 사용자 식별
        
        //2.파라미터는
        //  -http 구조 중 바디에 작성
        //  -딕셔너리 형태로 구현
        
        //3.상태코드 (Status Code): 서버의 응답 상태
        //  -200, 400, 500 상태 코드 모두 '성공'으로 간주
        //  -하지만 Alamofire: 200~300 코드를 defult validation으로 봄 -> validate한 상태 코드 확장 필요
        //  -일반적으로, 에러에 대한 상태코드를 401, 402, 403 등으로 세분화해서 주는 경우도 있고 (네이버처럼) 하나의 상태코드에 대해 다양한 에러 코드를 지정해주기도 함(서비스마다 다릅니다.)
        
        let url = NaverPapagoApi.url
        
        let headers : HTTPHeaders = [
            NaverPapagoApi.naverID : NaverPapagoApi.clientID,
            NaverPapagoApi.naverSecret : NaverPapagoApi.clientSecret
        ]
        
        let parameter = [
            "source" : lang1,
            "target" : lang2,
            "text" : msg
        ]
        
        //parmeters는 headers앞에 오는 것이 좋음
        //validate에서 400번때 코드도 인식할 수 있도록 확장 필요
        AF.request(url, method: .post, parameters: parameter, headers: headers).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                //응답받은
                let statusCode = response.response?.statusCode ?? 404
                
                switch statusCode {
                case NaverPapagoApiStatusCode.success.rawValue :
                    
                    print("JSON: \(json)")
                    let translatedText = json["message"]["result"]["translatedText"].stringValue
                    print("translatedText: \(translatedText)")
                    self.tfAfter.text = translatedText
                    
                case NaverPapagoApiStatusCode.fail.rawValue :
                    
                    print("실패")
                    print("JSON: \(json)")
                    let errMsg = json["errorMessage"].stringValue
                    self.lblTitle.text = errMsg
                    
                default:
                    print("실패")
                }
                
            case .failure(let error): //서버와 통신을 못할 때의 실패 케이스 ex)비행기 모드
                print(error)
            }
        }
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
