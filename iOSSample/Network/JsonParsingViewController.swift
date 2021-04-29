//
//  JsonParsingViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit

class JsonParsingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var movies : Array<Dictionary<String, String>> = []
    
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
        
        //데이터 다운로드
        let url = URL(string: "http://cyberadam.cafe24.com/movie/list")
        let data = try! Data(contentsOf: url!)
        
        //문자열로 변환
        let jsonString = String(data: data, encoding: .utf8)
        NSLog(jsonString!)
     
        //문자열을 딕셔너리로 변환
        let movieResult = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        //list키의 데이터를 배열로 변환
        let movieList = movieResult["list"] as! NSArray
        
        //배열의 데이터 순회
        for index in 0...(movieList.count - 1) {
            let movie = movieList[index] as! NSDictionary
            
            let title = movie["title"] as! String
            let image = movie["thumbnail"] as! String
            
            let dict = ["title": title, "image": image]
            
            movies.append(dict)
        }
        
        NSLog("\(movies)")
    }
    
}

extension JsonParsingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "movieListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        //행 번호에 해당하는 데이터를 가져오기
        let movie = movies[indexPath.row]
        //출력
        cell?.textLabel?.text = movie["title"]
        
        let imgUrl = "http://cyberadam.cafe24.com/movieimage/\(movie["image"]!)"
        let url = URL(string: imgUrl)
        let imgData = try! Data(contentsOf: url!)
        let img = UIImage(data: imgData)
        cell?.imageView?.image = img
        
        return cell!
    }
    
    
}
