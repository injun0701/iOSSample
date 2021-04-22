//
//  GestureViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/22.
//

import UIKit

class GestureViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이미지를 유저가 탭할 수 있도록 설정
        imgView.isUserInteractionEnabled = true
        
        //제스쳐 객체 생성
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureMethod(sender:)))
        //세부 옵션 설정 - 탭 몇번 하고 실행하는지 설정
        tap.numberOfTouchesRequired = 1
        //세부 옵션 설정 - 터치할 손가락 개수 설정
        //tap.numberOfTouchesRequired = 2
        //뷰에 제스쳐 객체 설정
        imgView.addGestureRecognizer(tap)
    }
    
    //탭 제스쳐 객체가 호출하는 메소드
    @objc func tapGestureMethod(sender:UITapGestureRecognizer) {
        //imgView의 모드가 UIViewContentModeScaleAspectFit 이면 Center로 변경
        if imgView.contentMode == UIView.ContentMode.scaleAspectFit {
            imgView.contentMode = UIView.ContentMode.scaleAspectFill
        } else {
            imgView.contentMode = UIView.ContentMode.scaleAspectFit
        }
    }
    
    
}
