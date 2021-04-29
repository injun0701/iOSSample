//
//  TableViewViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/23.
//

import UIKit

class TableViewViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //테이블 뷰에 출력 할 데이터를 소유한 배열
    var cars = [Dictionary<String, String>]()
    
    //refreshControl 객체 생성
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TableViewViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //데이터 추가
        cars.insert(["title": "스포츠카5", "subTitle": "5번째 스포츠카입니다.", "imageName": "car5.jpg"], at: 0)
        //refreshControl 제거
        refreshControl.endRefreshing()
        //테이블뷰 리로드
        self.tableView.reloadData()
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetting()
        tableViewDataSetting()
    }
    
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        //테이블뷰 경계선 없음 설정
        tableView.separatorStyle = .none
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
        tableView.addSubview(refreshControl)
        }
    }
    
    func tableViewDataSetting() {
        for i in 0...5 {
            cars.append(["title": "스포츠카\(i)", "subTitle": "\(i)번째 스포츠카입니다.", "imageName": "car\(i).jpg"])
        }
    }
}

extension TableViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    //행의 개수를 설정하는 메소드
    //section이 섹션(그룹) 번호
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 identifier로 사용할 문자열
        let cellIdentifier = "Cell"
        //재사용 가능한 셀이 있으면 찾아오기
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        //행 번호에 해당하는 데이터를 찾아오기
        let dict = cars[indexPath.row]
        
        //셀의 세부 속성 설정
        //문자열 배열의 데이터를 레이블에 출력
        //indexPath가 셀의 위치
        //indexPath.section은 그룹 번호
        //indexPath.row는 행의 번호
        cell.lblTitle.text = dict["title"]
        cell.lblSubTitle.text = dict["subTitle"]
        //이미지 출력
        cell.imgView.image = UIImage(named: (dict["imageName"]!))
        
        //배경색을 짝수로 생성
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(displayP3Red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        //선택했을 때 회색 배경 없음 설정
        cell.selectionStyle = .none
        
        return cell
    }
    
    //행의 높이를 설정하는 메소드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //행 들여쓰기를 설정하는 메소드
    func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        return 1
    }
    
    //셀을 선택했을때 설정하는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlertBtn1(title: "선택한 이름", message: cars[indexPath.row]["title"]!, btnTitle: "확인") {}
    }
}

