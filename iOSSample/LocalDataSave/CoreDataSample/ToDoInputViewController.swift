//
//  ToDoInputViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/03.
//

import UIKit
import CoreData

class ToDoInputViewController: UIViewController {
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tvCentents: UITextView!
    @IBOutlet var dpRuntime: UIDatePicker!
    @IBOutlet var btnAdd: UIButton!
    
    //삽입과 수정을 구분하기 위한 프로퍼티
    var mode = "저장"
    
    //수정을 위해 필요한 데이터
    var object:NSManagedObject!
    var dataTitle = ""
    var dataContents = ""
    var dataRuntime = Date()
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        //입력한 데이터 가져오기
        let title = tfTitle.text
        let contents = tvCentents.text
        let runtime = dpRuntime.date
        
        if title == "" || contents == "" {
            showAlertBtn1(title: "입력 오류", message: "입력란을 모두 작성해 주세요.", btnTitle: "확인") {}
        } else {
            if self.navigationController?.previousViewController() is ToDoViewController {
                
                //자신을 출력한 뷰(상위 뷰) 컨트롤러 찾아오기
                let toDoListVC = self.navigationController?.previousViewController() as! ToDoViewController
                
                if mode == "저장" {
                    //상위 뷰에서 데이터 삽입하는 메소드 호출
                    let result = toDoListVC.save(title: title!, contents: contents!, runtime: runtime)
                    //상위 뷰에서 데이터 삽입하는 메소드 호출 메소드의 리턴값
                    if result == true {
                        NSLog("데이터 삽입 성공")
                    } else {
                        NSLog("데이터 삽입 실패")
                    }
                } else {
                    //상위 뷰에서 데이터 삽입하는 메소드 호출
                    let result = toDoListVC.edit(object: object,title: title!, contents: contents!, runtime: runtime)
                    //상위 뷰에서 데이터 수정하는 메소드 호출 메소드의 리턴값
                    if result == true {
                        NSLog("데이터 수정 성공")
                    } else {
                        NSLog("데이터 수정 실패")
                    }
                }
                
            } else {
                NSLog("상위 뷰가 틀림")
            }
            
            //상위 뷰로 이동
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designSetting()
    }
    
    func designSetting() {
        tvCentents.layer.borderWidth = 0.3
        tvCentents.layer.borderColor = UIColor(displayP3Red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        tvCentents.layer.masksToBounds = true
        tvCentents.layer.cornerRadius = 4
        
        if mode == "수정" {
            btnAdd.setTitle(mode, for: .normal)
            tfTitle.text = dataTitle
            tvCentents.text = dataContents
            dpRuntime.date = dataRuntime
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
