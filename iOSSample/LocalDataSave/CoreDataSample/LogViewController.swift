//
//  TodoLogViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/04.
//

import UIKit

//데이터의 삽입, 수정, 삭제를 나타내기 위한 enum
//enu은 데이터를 제한하고자 할때 사용
public enum LogType:Int16 {
    case create = 0
    case edit = 1
    case delete = 2
}

//Int16 클래스에 기능을 추가
//swift나 kotlin, c#, javasript는 기존 클래스나 객체에 기능을 추가 가능
extension Int16 {
    func toLogType() -> String {
        switch self {
        case 0 : return "생성"
        case 1 : return "수정"
        case 2 : return "삭제"
        default : return ""
        }
    }
}

class LogViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //상위 뷰 컨트롤러에게서 넘겨받을 데이터
    var toDo:ToDoMO!
    
    //테이블 뷰에 출력할 데이터
    lazy var list : [LogMO]! = {
        return self.toDo.logs?.allObjects as! [LogMO]
    }()
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


extension LogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style:.default, reuseIdentifier:cellIdentifier)
        }
        
        //행번호에 해당하는 데이터 가져오기
        let log = list[indexPath.row]
       
        //출력하기
        cell?.textLabel?.text = "\(log.regdate!)에 \(log.type.toLogType()) 했습니다."
        
        return cell!
    }
    
    
   
}
