//
//  TableView3ViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/26.
//

import UIKit

class TableView3ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //사람이름을 가지고 있을 배열
    var data : Array<String> = []
    //각 섹션에 해당하는 데이터
    var sectionData : Array<Dictionary<String, Any>> = []
    //인덱스 항목을 가지고 있을 변수
    var indexes : Array<String> = []
    
    //이름을 넘겨주면 자음을 리턴해주는 메소드
    func subtract(data:String) -> String{
        var result = data.compare("나")
        if result == ComparisonResult.orderedAscending{
            return "ㄱ"
        }
        result = data.compare("다")
        if result == ComparisonResult.orderedAscending{
            return "ㄴ"
        }
        result = data.compare("라")
        if result == ComparisonResult.orderedAscending{
            return "ㄷ"
        }
        result = data.compare("마")
        if result == ComparisonResult.orderedAscending{
            return "ㄹ"
        }
        result = data.compare("바")
        if result == ComparisonResult.orderedAscending{
            return "ㅁ"
        }
        result = data.compare("사")
        if result == ComparisonResult.orderedAscending{
            return "ㅂ"
        }
        result = data.compare("아")
        if result == ComparisonResult.orderedAscending{
            return "ㅅ"
        }
        result = data.compare("자")
        if result == ComparisonResult.orderedAscending{
            return "ㅇ"
        }
        result = data.compare("차")
        if result == ComparisonResult.orderedAscending{
            return "ㅈ"
        }
        result = data.compare("카")
        if result == ComparisonResult.orderedAscending{
            return "ㅊ"
        }
        result = data.compare("타")
        if result == ComparisonResult.orderedAscending{
            return "ㅋ"
        }
        result = data.compare("파")
        if result == ComparisonResult.orderedAscending{
            return "ㅌ"
        }
        result = data.compare("하")
        if result == ComparisonResult.orderedAscending{
            return "ㅍ"
        }
        return "ㅎ"
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableViewDataSetting()
    }
    
    func tableViewDataSetting() {
        //데이터 생성
        data.append("김상중")
        data.append("김태리")
        data.append("김순진")
        data.append("박종오")
        data.append("박병호")
        data.append("한동인")
        data.append("이창진")
        data.append("이민호")
        data.append("추사랑")
        data.append("정우빈")
        data.append("장수원")
        data.append("박진경")
        data.append("정재영")
        data.append("추신수")
        data.append("최정")
        data.append("최정민")
        data.append("조용호")
        data.append("홍인준")
        data.append("홍수연")
        data.append("김혜정")
        data.append("김사랑")
        data.append("김준호")
        data.append("고준희")
        data.append("강심장")
        data.append("배정태")
        data.append("손아현")
        data.append("손흥민")
        data.append("박지성")
        data.append("이강인")
        data.append("신태용")
        data.append("강영덕")
        data.append("임대림")
        data.append("이호진")
        data.append("이성빈")
        data.append("이종국")
        data.append("김종국")
        data.append("유재석")
        data.append("하동훈")
        data.append("이광수")
        
        //인덱스 생성
        indexes.append("ㄱ")
        indexes.append("ㄴ")
        indexes.append("ㄷ")
        indexes.append("ㄹ")
        indexes.append("ㅁ")
        indexes.append("ㅂ")
        indexes.append("ㅅ")
        indexes.append("ㅇ")
        indexes.append("ㅈ")
        indexes.append("ㅊ")
        indexes.append("ㅋ")
        indexes.append("ㅌ")
        indexes.append("ㅍ")
        indexes.append("ㅎ")
        
        //data에 있는 데이터들을 첫글자의 자음별로 분류해서 sectionData에 대입
        var temp : [[String]] = Array(repeating:Array(), count:14)
        //각 자음별로 데이터를 임시로 저장할 2차원 배열을 생성
        //14번을 Array()를 호출해서 배열로 생성
        var i = 0
        while i < indexes.count {
            let firstName = indexes[i]
            var j = 0
            while j < data.count {
                let str = data[j]
                //첫글자의 자음과 firstName이 같으면
                if firstName == subtract(data: str) {
                    temp[i].append(str)
                }
                j = j + 1
            }
            i = i + 1
        }
        
        //분류된 데이터를 내부적으로 정렬
        i = 0
        while i < temp.count {
            if temp[i].count >= 2 {
                temp[i].sort()
            }
            i = i + 1
        }
        
        //데이터가 존재하는 것만 첫번째 글자와 배열을 딕셔너리로 묶어서 sectionData에 추가
        i = 0
        while i < indexes.count {
            if temp[i].count > 0 {
                var dic : Dictionary<String, Any> = [:]
                dic["section_name"] = indexes[i]
                dic["data"] = temp[i]
                sectionData.append(dic)
            }
            i = i + 1
        }
    }
}

extension TableView3ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { //섹션 번호에 해당하는 디셔너리를 sectionData에서 가져오기
        let dic = sectionData[section]
        //가져온 디셔너리에서 section_name이라는 키의 데이터를 가져오기
        let sectionName = (dic["section_name"] as! NSString) as String
        
        return sectionName
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //섹션 번호에 해당하는 디셔너리를 sectionData에서 가져오기
        let dic = sectionData[section]
        //가져온 디셔너리에서 section_name이라는 키의 데이터를 가져오기
        let ar = (dic["data"] as! NSArray) as Array
        
        return ar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) { cell = UITableViewCell(style:UITableViewCell.CellStyle.default, reuseIdentifier:cellIdentifier)
        }

        //섹션 번호에 해당하는 디셔너리를 sectionData에서 가져오기
        let dic = sectionData[indexPath.section]
        //가져온 디셔너리에서 section_name이라는 키의 데이터를 가져오기
        let ar = (dic["data"] as! NSArray) as Array
        cell!.textLabel!.text = (ar[indexPath.row] as! NSString) as String
        
        return cell!
    }
    
    
}
