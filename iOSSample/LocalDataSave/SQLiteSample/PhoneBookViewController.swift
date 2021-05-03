//
//  SQLiteViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/03.
//

import UIKit

class PhoneBookViewController: UIViewController {
    
    @IBOutlet var lblPhoneCount: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //테이블 뷰에 출력할 데이터 배열
    var phoneBook:[(num:Int, name:String, phone:String, addr:String)]!
    
    //DAO 객체
    let dao = PhoneBookDAO()
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        //대화상자 생성
        let alert = UIAlertController(title: "신규 등록", message: "등록한 연락처를 입력하세요.", preferredStyle: .alert)
        //입력란 만들기
        alert.addTextField { (tf) in
            tf.placeholder = "이름"
        }
        alert.addTextField { (tf) in
            tf.keyboardType = .phonePad
            tf.placeholder = "전화번호"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "주소"
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
            //입력한 내용 가져오기
            let name = alert.textFields?[0].text
            let phone = alert.textFields?[1].text
            let addr = alert.textFields?[2].text
            
            if name == "" || phone == "" || addr == "" {
                self.showAlertBtn1(title: "입력 오류", message: "입력란을 모두 작성해주세요.", btnTitle: "확인") {}
            } else {
                //데이터 삽입
                if self.dao.create(name: name, phone: phone, addr: addr) {
                    //데이터 다시 가져오기
                    self.phoneBook = self.dao.find()
                    //테이블 뷰 다시 출력
                    self.tableView.reloadData()
                    
                    //연락처 수 다시 출력
                    self.lblPhoneCount.text = "연락처 총\(self.phoneBook.count)명"
                }
            }
        }))
                        
        //대화상자 출력
        present(alert, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        //셀을 스와이프 할 때 편집 모드가 되도록 설정
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //전체 데이터 불러오기
        phoneBook = self.dao.find()
        //UI 초기화
        
        //연락처 수 출력
        lblPhoneCount.text = "연락처 총\(phoneBook.count)명"
        
    }
    
}

extension PhoneBookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellIdentifier)
        }
        
        //행번호에 해당하는 데이터 가져오기
        let record = phoneBook[indexPath.row]
        cell?.textLabel?.text = record.name
        cell?.detailTextLabel?.text = record.phone
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //삭제할 데이터의 번호를 찾아오기
        let num = self.phoneBook[indexPath.row].num
        
        //데이터 삭제
        if self.dao.remove(num: num) {
            self.phoneBook.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            lblPhoneCount.text = "연락처 총\(phoneBook.count)명"
        }
    }
    
}
