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
        let navi = sb.instantiateViewController(withIdentifier: "CollectionView1ViewController") as! CollectionView1ViewController
        navigationController?.pushViewController(navi, animated: true)
    }
   
    @IBAction func btnToNetworkSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Network", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "NetworkViewController") as! NetworkViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToRestfulApiSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RestApi", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "RestfulApiViewController") as! RestApiViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToLocalDataSaveSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "LocalDataSave", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "LocalDataSaveViewController") as! LocalDataSaveViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToAES256SampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "AES256", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "AES256ViewController") as! AES256ViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToLocationUseSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "LocationUse", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "LocationUseViewController") as! LocationUseViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToMapUseSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MapUse", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "MapUseViewController") as! MapUseViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
     @IBAction func btnToMultiMediaSampleAction(_ sender: UIButton) {
         let sb = UIStoryboard(name: "MultiMedia", bundle: nil)
         let navi = sb.instantiateViewController(withIdentifier: "MultiMediaViewController") as! MultiMediaViewController
         navigationController?.pushViewController(navi, animated: true)
     }
     
    
    var timer:Timer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //?????? ???????????? ????????? ??????
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            let date = Date()
            //?????? ??? ????????? ???????????? ????????? ?????? ???????????? ?????? ??????
            let formatter = DateFormatter()
            //????????? ?????? ??????
            formatter.dateFormat = "yyyy-MM-dd ccc hh:mm:ss"
            let msg = formatter.string(from: date)
            //?????????????????? ???????????? ?????? ??????????????? ?????? ????????? ?????? - ????????? ????????? ??????
            self.lblTimer.text = msg
        })
    }


}

