//
//  TableViewSampleViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/27.
//

import UIKit

class TableViewSampleViewController: UIViewController {
    
    @IBAction func btnToTableViewAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "TableViewSample", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "TableViewViewController") as! TableViewViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToTableView2Action(_ sender: UIButton) {
        let sb = UIStoryboard(name: "TableViewSample", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "TableView2ViewController") as! TableView2ViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToTableView3Action(_ sender: UIButton) {
        let sb = UIStoryboard(name: "TableViewSample", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "TableView3ViewController") as! TableView3ViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
