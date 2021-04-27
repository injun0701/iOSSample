//
//  CollectionViewSampleViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/27.
//

import UIKit

class CollectionViewSampleViewController: UIViewController {
    
    @IBAction func btnToCollectionView1Action(_ sender: UIButton) {
        let sb = UIStoryboard(name: "CollectionViewSample", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "CollectionView1ViewController") as! CollectionView1ViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
