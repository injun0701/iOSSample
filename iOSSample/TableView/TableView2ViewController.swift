//
//  TableView2ViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/26.
//

import UIKit

class TableView2ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //refreshControl 객체 생성
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TableView2ViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //데이터 추가
        let item = "apple watch"
        self.data?.insert(item, at: 0)
        //refreshControl 제거
        refreshControl.endRefreshing()
        //테이블뷰 리로드
        self.tableView.reloadData()
    }
    
    var data:Array<String>?
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "아이템 등록", message: "신규 아이템 이름을 입력하세요", preferredStyle: .alert)
        // 부서명 및 주소 입력용 텍스트 필드 추가
        alert.addTextField() { (tf) in tf.placeholder = "아이템 이름" }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in
            let item = alert.textFields?[0].text
            if item == nil || item!.trimmingCharacters(in: .whitespaces).count == 0 {
                return
            }
            
            //리스트 맨 앞(0번)에 추가
            self.data?.insert(item!, at: 0)
            //테이블뷰 리로드
            //self.tableView.reloadData()
            //테이블뷰 추가 시 애니메이션 동작
            self.tableView.beginUpdates()
            //with: .right 등 다양한 애니매이션이 있음
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            self.tableView.endUpdates()
            
            /*
            //리스트 맨 뒤에 추가
            self.data?.append(item!)
            //테이블뷰 리로드
            //self.tableView.reloadData()
            //테이블뷰 추가 시 애니메이션 동작
            self.tableView.beginUpdates()
            //with: .right 등 다양한 애니매이션이 있음
            self.tableView.insertRows(at: [IndexPath(row: self.data!.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
            */
        })
        self.present(alert, animated: false)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        data = ["iPod", "iPhone", "iPad"]
        
        tableViewSetting()
    }
    
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        // Drag & Drop 기능을 위한 부분
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
        tableView.addSubview(refreshControl)
        }
    }
    
}

extension TableView2ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style:.default, reuseIdentifier:cellIdentifier)
            
        }
        cell?.textLabel?.text = data![indexPath.row]
        
        return cell!
    }
    
    //데이터 소스에 주어진 행을 편집 할 수 있는지 확인하도록 요청하는 메소드
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //셀에서 오른쪽에서 왼쪽으로 스와이프 했을 때 호출되는 메소드(한가지 기능만 사용가능)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            data?.remove(at: indexPath.row)
            //tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    //테이블뷰가 편집 모드에있는 동안 지정된 행의 배경을 들여 쓰기해야하는지 체크하는 메소드
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
        
    }

    //데이터 소스에 테이블뷰의 특정 위치에있는 행을 다른 위치로 이동시키는 메소드
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = data?[sourceIndexPath.row]
        data?.remove(at: sourceIndexPath.row)
        data?.insert(movedObject!, at: destinationIndexPath.row)
        
    }
    
    //드래그 할 아이템을 리턴합니다. 리턴되는 array 가 비어 있으면 드래그를 시작하지 않습니다.
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
     
    //드래그가 끝나고 업데이트 합니다
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) ->  UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    //드롭에 관한 메소드
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
    
}
