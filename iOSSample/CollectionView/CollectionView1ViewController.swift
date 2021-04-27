//
//  CollectionVIew1ViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/27.
//

import UIKit

class CollectionView1ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    //컬렉션뷰에 출력 할 데이터를 소유한 배열
    var cars = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetting()
        collectionViewDataSetting()
    }
    
    func collectionViewSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionViewDataSetting() {
        for i in 0...5 {
            cars.append(["title": "스포츠카\(i)", "imageName": "car\(i).jpg"])
        }
    }
    
}

extension CollectionView1ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCollectionViewCell", for: indexPath) as! CarCollectionViewCell
        
        let car = cars[indexPath.row]
        //셀에 이미지 출력
        cell.imgView.image = UIImage(named: car["imageName"]!)
        cell.lbl.text = car["title"]
        
        return cell
    }
    
    //셀의 크기를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWidh = Int(collectionView.frame.width / 3)
        
        return CGSize(width: collectionViewCellWidh, height: collectionViewCellWidh)
    }
}
