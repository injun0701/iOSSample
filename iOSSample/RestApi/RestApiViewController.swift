//
//  RestfulApiViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit

class RestApiViewController: UIViewController {
    
    @IBAction func btnToKakaoSearchApiAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RestApi", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "KakaoSearchApiViewController") as! KakaoSearchApiViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToPostAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RestApi", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "PostSampleViewController") as! PostSampleViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToMovieListAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "RestApi", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "AlamofireMovieListViewController") as! MovieListViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
