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
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetting()
        collectionViewDataSetting()
    }
    
    func collectionViewSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //컬렉션뷰의 섹견의 경계 간격 설정
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
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
    
    //셀 간의 상하 간격을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //셀 간의 좌우 간격을 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //셀을 하이라이트 했을때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        //인덱스를 가지고 현재 선택한 셀을 찾아오기
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.green.cgColor
        cell?.layer.borderWidth = 4
    }
    
    //셀을 하이라이트 안했을때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        //인덱스를 가지고 현재 선택한 셀을 찾아오기
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0
    }

    //셀을 선택했을때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //인덱스를 가지고 현재 선택한 셀을 찾아오기
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.cyan.cgColor
        cell?.layer.borderWidth = 2
    }
    
    //셀을 선택 안했을때 호출되는 메소드
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //인덱스를 가지고 현재 선택한 셀을 찾아오기
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0
    }
        
    //헤더뷰 구현
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //출력할 뷰를 생성
        var reusableView : UICollectionReusableView! = nil
        
        //헤더 뷰 설정
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CarCollectionheaderView", for: indexPath) as! CarCollectionheaderView
            //셀에 이미지 출력
            headerView.imgViewHeader.image = UIImage(named: "banner1")
            headerView.lblHeader.text = "스포츠카 베너"
            
            reusableView = headerView
        }
        
        return reusableView
    }
}
