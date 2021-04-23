//
//  PickerViewViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/22.
//

import UIKit

class PickerViewViewController: UIViewController {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var lblResult: UILabel!
    @IBOutlet var imgResult: UIImageView!
    
    //이미지 이름 배열 생성
    var imgNames = [String]()
    //이미지 배열
    var imgs = [UIImage]()
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewSetting()
        imgSetting()
    }
    
    override func viewDidLayoutSubviews() {
        //피커뷰 선택 표시하는 회색배경 설정
        pickerView.subviews[1].layer.backgroundColor = UIColor(displayP3Red: 200/250, green: 200/250, blue: 200/250, alpha: 0).cgColor
        pickerView.subviews[1].layer.borderWidth = 1
        pickerView.subviews[1].layer.borderColor = UIColor(displayP3Red: 200/250, green: 200/250, blue: 200/250, alpha: 1).cgColor
    }
    
    func pickerViewSetting() {
        //이벤트 처리하기 위해서 필요한 메소드는 self에서 찾아서 사용 - 없으면 실행 안함
        pickerView.delegate = self
        //출력하기 위해서 필요한 메소드는 self에서 찾아서 사용 - 없으면 실행 안함
        pickerView.dataSource = self
    }
    
    func imgSetting() {
        //이미지 파일 이름 배열 초기화
        for i in 0...5 {
            imgNames.append("car\(i)")
        }
        
        //이미지 배열 초기화
        for temp in imgNames {
            imgs.append(UIImage(named: temp)!)
        }
        
        lblResult.text = "파일 이름: car0.jpg"
        imgResult.image = UIImage(named: "car0")
        
    }
}

extension PickerViewViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //열의 개수를 설정하는 메소드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //열 별로 행의 개수를 설정하는 메소드
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imgNames.count
    }
    
    //출력할 문자열을 설정하는 메소드
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imgNames[row]
    }
    
    //뷰를 출력하는 메소드
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //출력할 뷰를 생성
        let imgView = UIImageView(image: imgs[row])
        //너비의 높이를 생성
        imgView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        //출력 설정
        return imgView
    }
    
    //높이를 설정하는 메소드
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120
    }
    
    //피커 뷰의 선택이 변경되었을 때 호출되는 메소드
    //component: 열
    //row: 행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //레이블에 선택한 항목을 출력
        lblResult.text = "파일 이름: \(imgNames[row]).jpg"
        imgResult.image = UIImage(named: imgNames[row])
    }
}
