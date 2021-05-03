//
//  ToDoViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/03.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
    
    //전체 데이터를 읽어오는 메소드
    func fetch() -> [NSManagedObject] {
        //코어 데이터 사용을 위한 저장소를 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //요청 객체 생성 - ToDo Entity의 데이터를 가져오도록 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo")
        //데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    //읽어온 데이터를 저장할 배열
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()
    
    //데이터 저장을 위한 메소드
    func save(title: String, contents: String, runtime: Date) -> Bool {
        //코어 데이터 사용을 위한 저장소를 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //데이터 삽입
        let object = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        do {
            //데이터 삽입
            try context.save()
            self.list.append(object)
            self.list = self.fetch()
            self.tableView.reloadData()
            return true
        } catch {
            context.rollback()
            return false
        }
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "LocalDataSave", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ToDoInputViewController") as! ToDoInputViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellIdentifier)
        }
        
        //행번호에 해당하는 데이터 가져오기
        let record = list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        //출력하기
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = contents
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
       
    }
    
}
