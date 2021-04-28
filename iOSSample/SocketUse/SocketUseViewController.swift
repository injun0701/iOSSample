//
//  SocketUseViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/28.
//

import UIKit

class SocketUseViewController: UIViewController {

    
    @IBOutlet var tfMsg: UITextField!
    @IBOutlet var tvMsg: UITextView!
    
    //통신할 서버의 IP와 포트 번호
    let host = "192.168.0.4"
    let port = 9999
    //통신할 클라이언트 프로퍼티
    var client: TCPClient?
    
    //문자열을 대입받아서 텍스트뷰에 추가하는 메소드
    func appendToTextView(string:String) {
        tvMsg.text = tvMsg.text.appending("\n\(string)")
    }
    
    //서버로부터 받은 데이터를 문자열로 만들어서 리턴하는 메소드
    func readResponse(from client:TCPClient) -> String? {
        //받은 데이터를 response에 저장하고 받은게 없으면 nil을 리턴
        guard let response = client.read(1024 * 10)
        else {
            return nil
        }
        
        return String(bytes: response, encoding: .utf8)
    }
    
    //요청을 전달하는 메소드
    func sendRequest(string: String, using client: TCPClient) -> String? {
        appendToTextView(string: "데이터 전송 중...")
        
        //서버에게 전송
        switch client.send(string:string) {
        case .success:
            return readResponse(from: client)
        case .failure(let error):
            appendToTextView(string: String(describing: error))
            return nil
        }
    }
    
    
    @IBAction func sendMessage(_ sender: UIButton) {
        //클라이언트 가져오기
        guard  let client = client else {
            return
        }
        
        //서버 연결
        switch client.connect(timeout: 60) {
        case .success: //성공하면 입력한 메시지 전송
            appendToTextView(string: "서버 연결 성공")
            if let response = sendRequest(string: "\(tfMsg.text!)\n\n", using: client) {
                appendToTextView(string: "응답: \(response)")
            }
        case .failure(let error): //실패하면 실패메시지 출력
            appendToTextView(string: String(describing: error))
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCheck()
    }
    
    //네트워크 체크
    func networkCheck() {
        //client 초기화
        client = TCPClient(address: host, port: Int32(port))
        
        //네트워크 사용 여부 확인
        let reachability = Reachability()
        let result = reachability.isConnectedToNetwork()
        
        var msg = ""
        if result == true {
            msg = "네트워크 사용 가능"
        } else {
            msg = "네트워크 사용 불가능"
        }
        
        //대화상자로 출력하기
        let alert = UIAlertController(title: "네트워크 사용 여부", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        
        self.present(alert, animated: true)
    }

}
