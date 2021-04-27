//
//  ImgScrollViewViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/22.
//

import UIKit

class ImgScrollViewViewController: UIViewController {

    var imgView: UIImageView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgSetting()
    }
    
    func imgSetting() {
        //이미지 객체 생성
        let image:UIImage! = UIImage(named: "large.jpg")
        //이미지 뷰 생성
        imgView = UIImageView(image: image)
        //이미지를 유저가 탭할 수 있도록 설정
        imgView.isUserInteractionEnabled = true
        
        //이미지 뷰 크기를 저장
        let imageSize = imgView!.frame.size
        
        //스크롤 뷰 사이즈 설정
        let scrollViewSize = CGRect(x: 0, y: 140, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300)
        //스크롤뷰 객체 생성
        let scrollView = UIScrollView(frame: scrollViewSize)
        //스크롤 뷰 옵션 설정
        scrollView.isScrollEnabled = true
        //내용 크기 설정
        scrollView.contentSize = imageSize
        //바운스 속성 설정
        scrollView.bounces = false
        //이미지뷰를 스크롤뷰에 추가
        scrollView.addSubview(imgView)
        
        //스크롤뷰를 현재 뷰 컨트롤러에 배치
        self.view.addSubview(scrollView)
        
        //줌 관련 설정
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self
    }
}

extension ImgScrollViewViewController: UIScrollViewDelegate {
    //확대 축소가 발생할 뷰를 설정하는 메소드
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }

}
