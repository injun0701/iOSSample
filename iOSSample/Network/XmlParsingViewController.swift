//
//  XmlparsingViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/28.
//

import UIKit

class XmlParsingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    //태그 안의 내용을 저장할 프로퍼티
    var elementValue:String!
    //하나의 객체를 저장할 프로퍼티
    var book:BookList!
    //파싱한 모든 데이터를 저장할 프로퍼티
    var books:Array<BookList> = []
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetting()
        xmlParsingSetting()
    }
    
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //파싱 메소드
    func xmlParsingSetting() {
        //다운로드 받을 URL을 생성
        let url = URL(string: "http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        //파서 객체를 생성
        let xmlParser = XMLParser(contentsOf: url!)
        //파싱을 위임
        xmlParser!.delegate = self
        let suceess = xmlParser?.parse() //xmlParserDelegate의 메소드를 구현한 객체를 설정
        if suceess == true {
            self.title = "파싱 성공"
        } else {
            self.title = "파싱 실패"
        }
    }
}

extension XmlParsingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "bookListCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        //행 번호에 해당하는 데이터를 가져오기
        let book = books[indexPath.row]
        //출력
        cell?.textLabel?.text = "\(book.title ?? "") - \(book.author ?? "")"
        
        return cell!
    }
    
}

extension XmlParsingViewController: XMLParserDelegate {
    //태그가 시작될때 호출되는 메소드
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //객체를 생성하는 키를 만났을때 파싱한 데이터를 저장할 객체를 생성
        //속성이 있다면 속성을 저장
        if elementName == "Book" {
            book = BookList()
            
            let dic = attributeDict as Dictionary
            book.bookId = dic["id"]
        }
    }
    
    //태그 안의 내용을 만났을때 호출되는 메소드
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //태그는 128글자를 못넘지만 태그안에 있는 글자수 제한이 없음 즉 한번에 오는게 아니라 나눠서 올수도 있음
        //처음 후출되는 것인지 아니면 연속해서 호출되는 것인지 판단해서 처음 호출일 경우 문자로 바로 대입, 아니면 기존 문자열에 추가
        if elementValue == nil {
            elementValue = string
        } else {
            elementValue = "\(elementValue!)\(string)"
        }
    }
    
    //닫는 태그를 만났을때 호출되는 메소드 - 여기서 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Books" {
            return
        }
        if elementName == "Book" {
            //배열에 데이터를 저장
            books.append(book)
        } else {
            //세부 태그가 종료될때 문자열을 속성에 저장
            if elementName == "title" {
                book.title = elementValue
            } else if elementName == "author" {
                book.author = elementValue
            } else if elementName == "summary" {
                book.summary = elementValue
            }
            elementValue = nil
        }
    }
}
