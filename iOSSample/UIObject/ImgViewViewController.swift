//
//  ImgViewViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class ImgViewViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var slider: UISlider!
    
    //애니메이션에 사용할 이미지 배열
    var imgArray = [UIImage]()
    //현재 출력 중인 이미지의 인덱스
    var i:Int?
    //애니메니션 속도
    var speed:Float?
    
    @IBAction func changeSpeed(_ sender: UISlider) {
        //슬라이더의 값을 speed에 저장
        speed = slider.value
        //애니메이션 진행 중이면 멈추고 다시 시작
        if imgView.isAnimating == true {
            imgView.stopAnimating()
            
            //애니메이션 시간 설정
            imgView.animationDuration = TimeInterval(Int(speed! * 3) * imgArray.count)
            
            //애니메이션 시작
            imgView.startAnimating()
        }
    }
    @IBAction func btnPlayAction(_ sender: UIButton) {
        //애니메이션을 중지 중인지 확인
        if imgView.isAnimating == false {
            //애니메이션 시간 설정
            imgView.animationDuration = TimeInterval(Int(speed! * 3) * imgArray.count)
            //애니메이션 시작
            imgView.startAnimating()
            //버튼의 타이틀 변경
            (sender).setTitle("중지", for: .normal)
        } else {
            //애니메이션 중지
            imgView.stopAnimating()
            //버튼의 타이틀 변경
            (sender).setTitle("시작", for: .normal)
        }
    }
    @IBAction func btnPrevAction(_ sender: UIButton) {
        i = i! - 1
        if i! < 0 {
            i = imgArray.count - 1
        }
        imgView.image = imgArray[i!]
    }
    @IBAction func btnNextAction(_ sender: UIButton) {
        i = i! + 1
        if i! == imgArray.count {
            i = 0
        }
        imgView.image = imgArray[i!]
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgArraySetting()
    }
    
    func imgArraySetting() {
        //이미지 배열 데이터 삽입
        for i in 0...5 {
            imgArray.append(UIImage(named: "car\(i)")!)
        }
        
        i = 0
        
        speed = 0.5
        
        //이미지 뷰 초기화
        imgView.image = imgArray[i!]
        imgView.animationImages = imgArray
    }
    
}
