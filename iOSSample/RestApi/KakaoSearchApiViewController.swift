//
//  KakaoSearchApiViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit
import Alamofire

class KakaoSearchApiViewController: UIViewController {
    @IBOutlet var tfSearch: UITextField!
    
    @IBAction func btnSearchAction(_ sender: UIButton) {
        if tfSearch.text == "" {
            let alert = UIAlertController(title: "검색어 오류", message: "검색어를 입력하세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .default))
                            
            self.present(alert, animated: true)
        } else {
            //네트워크 사용 여부 확인
            networkCheck() { [self] in
                kakaoSearchApiSetting()
            }
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    //파싱한 모든 데이터를 저장할 프로퍼티
    var books:Array<Dictionary<String, String>> = []
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //네트워크 사용 여부 확인
        networkCheck() { [self] in
            kakaoSearchApiSetting()
        }
    }
    
    func kakaoSearchApiSetting() {
        //초기화
        books = []
        
        //다운로드 받을 URL 생성
        let addr = "https://dapi.kakao.com/v3/search/book?target=title&query="
        let query = "\(tfSearch.text!)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let url = "\(addr)\(query!)"
        
        let headers : HTTPHeaders = [ "Authorization" : "KakaoAK ab773b5c386b0b2a77605c2b6b2b66ae" ]
        
        //헤더를 추가한 요청 객체 만들기
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
        //json 요청
        request.responseJSON {
            response in
            
            print(response.value!)
            
            //다운로드 받은 데이터를 딕셔너리로 변환
            if let result = response.value as? [String:Any] {
                
                let documents = result["documents"] as! NSArray
                if documents.count != 0 {
                    for index in 0...(documents.count - 1) {
                        //데이터 하나 가져오기
                        let item = documents[index] as! NSDictionary
                        let title = item["title"]!
                        let price = item["price"]!
                        
                        NSLog("\(title):\(price)")
                        
                        let dic = ["title":"\(title)", "price": "\(price)"]
                        
                        self.books.append(dic)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){         self.view.endEditing(true)
    }
}


extension KakaoSearchApiViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "bookListCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        //행 번호에 해당하는 데이터를 가져오기
        let book = books[indexPath.row]
        //출력
        cell?.textLabel?.text = "\(book["title"] ?? "") - \(book["price"] ?? "")"
        
        return cell!
    }
    
}
