//
//  ViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblTimer: UILabel!
    
    @IBAction func btnToUIObjectSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "UIObject", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "UIObjectViewController") as! UIObjectViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToMotionSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Motion", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "MotionViewController") as! MotionViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToGestureSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Gesture", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "GestureViewController") as! GestureViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToScrollViewSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "ScrollView", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "ScrollViewViewController") as! ScrollViewViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToWebViewSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "WebView", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToTableViewSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "TableViewSample", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "TableViewSampleViewController") as! TableViewSampleViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToCollectionViewSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "CollectionViewSample", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "CollectionViewSampleViewController") as! CollectionViewSampleViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    var timer:Timer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //바로 시작하는 타이머 생성
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            let date = Date()
            //날짜 및 시간을 문자열로 만들어 주는 클래스이 겍체 생성
            let formatter = DateFormatter()
            //문자열 서실 설정
            formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
            let msg = formatter.string(from: date)
            //클러저에서는 클래스에 만든 프로퍼티가 직접 사용이 안됨 - 객체를 통해서 접근
            self.lblTimer.text = msg
        })
    }


}

