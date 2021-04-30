//
//  AlamofireMovieListViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit
import Alamofire

class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //현재 출력한 체이지 번호를 저장할 프로퍼티
    var page = 0
    //마지막 셀이 처음 보여진 것인지 여부를 설정하는 프로퍼티
    var flag = false
    
    //파싱한 결과를 저장할 프로퍼티
    var movieList : Array<MovieVO> = []
    
    //데이터를 파싱해서 저장하고 테이블 뷰를 다시 출력하는 사용자 정의 함수
    func downloadData() {
        //이 메소드가 호출될때 마다 페이지 수 1씩 증가
        page = page + 1
        
        //다운로드 받을 URL을 생성
        let addr = "http://cyberadam.cafe24.com/movie/list?page=\(page)"
        //위의 URL에 get 방식으로 요청할 객체를 생성
        let request = AF.request(addr, method: .get, encoding: JSONEncoding.default, headers: [:])
        //JSON 결과를 가져와서 사용하기
        request.responseJSON { response in
            //전체 데이터를 딕셔너리로 변환
            if let jsonResult = response.value as? [String:Any] {
                if let list = jsonResult["list"] as? NSArray{
                    //리스트 개수가 0이 아니면
                    if list.count != 0 {
                        //배열의 순회
                        for index in 0...(list.count-1) {
                            //데이터를 하나씩 순서대로 가져옴
                            let item = list[index] as! NSDictionary
                            //데이터를 저장할 객체 생성
                            var movie = MovieVO()
                            movie.title = item["title"] as? String
                            movie.genre = item["genre"] as? String
                            movie.link = item["link"] as? String
                            movie.thumbnail = item["thumbnail"] as? String
                            movie.rating = (item["rating"] as! NSNumber).doubleValue //실수로 변환해서 저장
                            
                            //thumbnail 값을 이용해서 이미지를 다운로드 방아서 movie.image에 대임
                            let url = URL(string: "http://cyberadam.cafe24.com/movieimage/\(movie.thumbnail ?? "REP_02310041598_1_1_0839.jpg")")
                            let imageData = try? Data(contentsOf: url!)
                            //이미지 기본값
                            let defaultUrl = URL(string: "http://cyberadam.cafe24.com/movieimage/REP_02310041598_1_1_0839.jpg")
                            let defaultimageData = try? Data(contentsOf: defaultUrl!)
                            
                            movie.image = UIImage(data: (imageData ?? defaultimageData)!)
                            
                            //배열의 데이터 저장
                            self.movieList.append(movie)
                        }
                        //테이블 뷰를 다시 출력
                        self.tableView.reloadData()
                        //데이터를 콘솔에 출력
                        NSLog("\(self.movieList)")
                    }
                }
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        //네트워크 사용 여부 확인
        networkCheck() { [self] in
            downloadData()
        }
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //사용자 정의 셀 객체를 생성
        let cellIdentifier = "movieListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        
        //데이터 찾아오기
        let movie = movieList[indexPath.row]
        
        //데이터 출력
        cell.lblTitle.text = movie.title!
        cell.lblGenre.text = movie.genre!
        cell.lblRating.text = "별점: \(movie.rating!)"
        cell.imgView.image = movie.image!
        
        return cell
    }
    
    //테이블 뷰에서 스트롤을 하면 호출되는 메소드 (셀이 보여질때 호출되는 메소드)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //처음 마지막 셀이 출력되면
        if flag == false && indexPath.row == self.movieList.count - 1 {
            flag = true
        } else if flag == true && indexPath.row == self.movieList.count - 1 {
            //네트워크 사용 여부 확인
            networkCheck() { [self] in
                downloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //하위 뷰 컨트롤러 생성
        let vc = storyboard?.instantiateViewController(identifier: "MovieListLinkViewController") as! MovieListLinkViewController
        //행번호에 해당하는 데이터 찾아오기
        let movie = movieList[indexPath.row]
        //하위 뷰 컨트롤러에 데이터 넘겨주기
        vc.movieLink = movie.link
        vc.movieTitle = movie.title
        //하위 뷰 컨트롤러 출력
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
