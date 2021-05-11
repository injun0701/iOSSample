//
//  MultiMediaViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/11.
//

import UIKit
import AVKit

class MultiMediaViewController: UIViewController {
    
    @IBAction func btnToAudioPlayerSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MultiMedia", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "AudioPlayerViewController") as! AudioPlayerViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnToAudioRecordSampleAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MultiMedia", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "AudioRecordViewController") as! AudioRecordViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnVideoPlayAction(_ sender: UIButton) {
        //동영상 url 생성
        let filePath:String? = Bundle.main.path(forResource: "ipadVideo", ofType: "mp4")
        let url = URL(fileURLWithPath:filePath!)
        
        //동영상 재생기 생성
        let player = AVPlayer(url:url)
        //동영상 재생기를 사용할 동영상 재생 뷰 컨트롤러 생성
        let playerController = AVPlayerViewController()
        //동영상 재생 뷰 컨트롤러에 재생기 연결
        playerController.player = player
        
        //동영상 재생 뷰 컨트롤러 출력
        self.present(playerController, animated: true){
            player.play() // 비디오 재생
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
