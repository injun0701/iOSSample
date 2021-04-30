//
//  LocalDataSaveViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit

class LocalDataSaveViewController: UIViewController {
    
    @IBAction func toAppDelegateSample(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AppDelegateViewController") as! AppDelegateViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func toDocumentFileSaveSample(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "DocumentFileSaveViewController") as! DocumentFileSaveViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
