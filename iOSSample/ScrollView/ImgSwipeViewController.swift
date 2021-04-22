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
        //스크롤 뷰 생성 - 한페이지의 크기를 설정
        scrollView = UIScrollView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 200, y: 20, width: 400, height: 400))
        //스크롤 뷰에 출력할 내용 생성
        contentView = UIView(frame: CGRect(x: 0, y: 90, width: 2400, height: 400))
        
        //반복문을 수행해서 contentView의 내용을 만듬
        var t : Int = 0
        for i in 0...5 {
            //이미지 뷰를 x 좌표를 변경하면서 생성
            let imageView = UIImageView(frame: CGRect(x: t, y: 0, width: 400, height: 400))
            //이미지 설정
            imageView.image = UIImage(named: "car\(i).jpg")
            //항목 뷰에 배치
            contentView?.addSubview(imageView)
            
            t = t + 400
        }
        
        scrollView!.addSubview(contentView)
        scrollView?.contentSize = contentView!.frame.size
        self.view.addSubview(scrollView)
        scrollView?.isPagingEnabled = true
        
    }

}
