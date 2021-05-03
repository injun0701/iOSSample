//
//  DocumentFileSaveViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit

class DocumentFileSaveViewController: UIViewController {

    @IBOutlet var tfDocumentSave: UITextField!
    @IBOutlet var tvFileText: UITextView!
    
    //문서 저장 버튼
    @IBAction func btnDocumentFileSaveAction(_ sender: UIButton) {
        if tfDocumentSave.text == "" {
            showAlertBtn1(title: "입력 오류", message: "파일에 저장할 내용을 입력해주세요.", btnTitle: "확인") {}
        } else {
            documentFileSave(text: tfDocumentSave.text!)
        }
    }
    
    //문서 저장 메소드
    func documentFileSave(text: String = "스위프트 파일 저장") {
        //도큐먼트 디렉토리 경로 만들기
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        
        //파일 경로 생성
        let dataFile = docsDir + "/data.txt"
        
        //파일에 기록할 내용
        let dataBuffer = text.data(using: .utf8)
        
        //파일에 기록
        FileManager.default.createFile(atPath: dataFile, contents: dataBuffer, attributes: nil)
        
        if FileManager.default.contents(atPath: dataFile) != nil { //만약 파일이 저장되었다면
            showAlertBtn1(title: "파일 자장", message: "파일 저장을 성공했습니다.", btnTitle: "확인") {}
        } else { //아니면
            showAlertBtn1(title: "파일 오류", message: "파일 저장을 실패했습니다.", btnTitle: "확인") {}
        }
    }
    
    //문서 읽기 버튼
    @IBAction func btnDocumentFileReadAction(_ sender: UIButton) {
        documentFileRead()
    }
    
    //문서 읽기 메소드
    func documentFileRead() {
        //도큐먼트 디렉토리 경로 만들기
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0]
            //파일 경로 생성
            let dataFile = docsDir + "/data.txt"
                
            //파일이 존재한다면 파일의 내용 읽어오기
            if let dataBuffer = FileManager.default.contents(atPath: dataFile) {
            
            //문자열로 변환
            let msg = String(data: dataBuffer, encoding: .utf8)
            
            //출력
            tvFileText.text = msg
                
        } else { //파일이 존재하지 않으면
            showAlertBtn1(title: "파일 오류", message: "파일이 존재하지 않습니다.", btnTitle: "확인") {}
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
