//
//  ImgSwipeViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/22.
//

import UIKit

class ImgSwipeViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgSwipe()
    }
    
    func imgSwipe() {
        
        //스크롤뷰의 높이, 넓이
        let scrollViewHeight = 300
        let scrollViewWidth = 400
        
        //스크린의 중간
        let UIScreenMiddle = Int(UIScreen.main.bounds.width) / 2 - (scrollViewWidth / 2)
        
        //스크롤 뷰 생성 - 한페이지의 크기를 설정
        scrollView = UIScrollView(frame: CGRect(x: UIScreenMiddle, y: 140, width: scrollViewWidth, height: scrollViewHeight))
        //스크롤 뷰에 출력할 내용 생성
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: scrollViewWidth * 6, height: scrollViewHeight))
        
        //반복문을 수행해서 contentView의 내용을 만듬
        var t : Int = 0
        for i in 0...5 {
            //이미지 뷰를 x 좌표를 변경하면서 생성
            let imageView = UIImageView(frame: CGRect(x: t, y: 0, width: scrollViewWidth, height: scrollViewHeight))
            //이미지 설정
            imageView.image = UIImage(named: "car\(i).jpg")
            //항목 뷰에 배치
            contentView?.addSubview(imageView)
            
            t = t + scrollViewWidth
        }
        
        scrollView!.addSubview(contentView)
        scrollView?.contentSize = contentView!.frame.size
        self.view.addSubview(scrollView)
        scrollView?.isPagingEnabled = true
        
    }

}
