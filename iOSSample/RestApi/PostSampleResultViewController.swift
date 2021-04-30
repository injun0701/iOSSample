//
//  PostSampleResultViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit
import Alamofire

class PostSampleResultViewController: UIViewController {
    
    var listArray : Array<Dictionary<String, String>> = []

    @IBOutlet var tableView: UITableView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //네트워크 사용 여부 확인
        networkCheck() { [self] in
            movieDataSetting()
        }
    }
    
    //josn parsing 메소드
    func movieDataSetting() {
        
        //초기화
        listArray = []
        
        //데이터 다운로드
        let url = URL(string: "http://cyberadam.cafe24.com/item/list")
        let data = try! Data(contentsOf: url!)
        
        //문자열로 변환
        let jsonString = String(data: data, encoding: .utf8)
        NSLog(jsonString!)
     
        //문자열을 딕셔너리로 변환
        let itemResult = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        //list키의 데이터를 배열로 변환
        let itemList = itemResult["list"] as! NSArray
        
        //배열의 데이터 순회
        for index in 0...(itemList.count - 1) {
            let item = itemList[index] as! NSDictionary
            
            let itemid = item["itemid"] as! Int
            let title = item["itemname"] as! String
            let price = item["price"] as! Int
            let description = item["description"] as! String
            let pictureurl = item["pictureurl"] as! String
            
            let dict = ["itemid":"\(itemid)", "itemname": title, "price":"\(price)", "description":description, "pictureurl": pictureurl]
            
            listArray.append(dict)
        }
        
        NSLog("\(listArray)")
        self.tableView.reloadData()
    }
    
}


extension PostSampleResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "itemListCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostSampleResultCell else {
            return UITableViewCell()
        }
        
        //행 번호에 해당하는 데이터를 가져오기
        let item = listArray[indexPath.row]
        //출력
        cell.lblTitle.text = item["itemname"]
        cell.lblPrice.text = item["price"]
        cell.lblDescription.text = item["description"]
        
        let imgUrl = "http://cyberadam.cafe24.com/img/\(item["pictureurl"]!)"
        let url = URL(string: imgUrl)
        let imgData = try! Data(contentsOf: url!)
        let img = UIImage(data: imgData)
        cell.imgView.image = img
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showAlertBtn2(title: "아이템 삭제", message: "삭제하시겠습니까?", btn1Title: "취소", btn2Title: "삭제") {
           
        } btn2Action: {
            //행 번호에 해당하는 데이터를 가져오기
            let item = self.listArray[indexPath.row]
            
            //파라미터 만들기
            let parameters = ["itemid":item["itemid"]]
            let request = AF.request("http://cyberadam.cafe24.com/item/delete", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
            request.responseJSON { response in
                if let jsonResult = response.value as? [String:Any] {
                    let result = jsonResult["result"] as! Int
                    NSLog("결과:\(result)")
                    if result == 1 {
                        self.showAlertBtn1(title: "삭제 성공", message: "삭제 성공했습니다.", btnTitle: "확인") {
                            self.movieDataSetting()
                        }
                    } else {
                        self.showAlertBtn1(title: "삭제 실패", message: "삭제 실패했습니다.", btnTitle: "확인") {}
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

