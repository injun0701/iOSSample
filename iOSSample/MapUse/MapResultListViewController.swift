//
//  MapResultListViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/10.
//

import UIKit
import MapKit

class MapResultListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //이전 뷰 컨트롤러에서 데이터를 넘겨받을 프로퍼티
    var mapItem: [MKMapItem]?
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetting()
    }
    
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MapResultListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mapItem?.count == 0 {
            return 1
        } else {
            return mapItem!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style:.subtitle, reuseIdentifier:cellIdentifier)
        }
        
        if mapItem?.count == 0 {
            cell?.textLabel?.text = "검색 결과가 없습니다."
            cell?.detailTextLabel?.text = "다시 검색해주세요."
        } else {
            //데이터 찾아와서 출력하기
            if let item = mapItem?[indexPath.row] {
                cell?.textLabel?.text = item.name
                cell?.detailTextLabel?.text = item.phoneNumber
                
                cell?.accessoryType = .disclosureIndicator
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mapItem?.count != 0 {
            let vc = self.storyboard?.instantiateViewController(identifier: "MapResultRouteViewController") as! MapResultRouteViewController
            if let indexPath = self.tableView.indexPathForSelectedRow, let destination = mapItem?[indexPath.row] {
                vc.destination = destination
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
