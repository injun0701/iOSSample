//
//  ToDoViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/03.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController {
    
    //읽어온 데이터를 저장할 배열
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()
    
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
    
    //데이터 저장 메소드
    func save(title: String, contents: String, runtime: Date) -> Bool {
        //코어 데이터 사용을 위한 저장소를 가져오기
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 3. 컨텍스트로부터 해당 데이터 삽입(ToDO)
        let object = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        // 3. 컨텍스트로부터 해당 데이터 삽입(Log)
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        // 데이터 설정
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue
        
        // 1:N 관게의 데이터 삽입
        (object as! ToDoMO).addToLogs(logObject)
        
        // 4. 영구 저장소에 커밋
        do {
            //데이터 삽입
            try context.save()
            self.list.append(object)
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    //데이터 수정 메소드
    func edit(object: NSManagedObject, title: String, contents: String, runtime:Date) -> Bool {
        //코어 데이터 사용을 위한 저장소를 가져오기
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 3. 컨텍스트로부터 해당 데이터 수정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(runtime, forKey: "runtime")
        
        // 3. 컨텍스트로부터 해당 데이터 수정(Log)
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        // 데이터 설정
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue
        
        // 1:N 관게의 데이터 삽입
        (object as! ToDoMO).addToLogs(logObject)
        
        // 4. 영구 저장소에 커밋
        do {
            //데이터 삽입
            try context.save()
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    //데이터 삭제 메소드
    func delete(object: NSManagedObject) -> Bool{
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        // 3. 컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        // 4. 영구 저장소에 커밋
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        //출력할 뷰 컨트롤러를 생성
        let sb = UIStoryboard(name: "LocalDataSave", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ToDoInputViewController") as! ToDoInputViewController
        //삽입과 수정 모드를 구분하기 위한 프로 퍼티를 설정
        navi.mode = "저장"
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
        //detailDisclosureButton 추가
        cell?.accessoryType = UITableViewCell.AccessoryType.detailButton
        
        //행번호에 해당하는 데이터 가져오기
        let record = list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        //출력하기
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = contents
        
        return cell!
    }
    
    //셀 클릭 이벤트 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //넘겨줄 데이터 찾아오기
        let object = self.list[indexPath.row]
        
        //각각의 데이터 찾아오기
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        let runtime = object.value(forKey: "runtime") as? Date
        
        //출력할 뷰 컨트롤러를 생성
        let sb = UIStoryboard(name: "LocalDataSave", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ToDoInputViewController") as! ToDoInputViewController
        //삽입과 수정 모드를 구분하기 위한 프로 퍼티를 설정
        navi.mode = "수정"
        
        navi.object = object
        navi.dataTitle = title!
        navi.dataContents = contents!
        navi.dataRuntime = runtime!
        
        //출력
        navigationController?.pushViewController(navi, animated: true)
    }
    
    //detailButton 클릭 이벤트 메소드
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogViewController") as! LogViewController
        //데이터 전달
        uvc.toDo = object as? ToDoMO

        self.show(uvc, sender: self)

    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let object = self.list[indexPath.row]
        // 삭제할 대상 객체
        if self.delete(object: object) {
            // 코어 데이터에서 삭제되고 나면 배열 해당 목록 삭제
            self.list.remove(at: indexPath.row)
            // 테이블 뷰의 해당 행도 삭제
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
