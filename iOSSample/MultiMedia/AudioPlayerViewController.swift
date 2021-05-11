//
//  AudioPlayerViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/11.
//

import UIKit
import AVFoundation

class AudioPlayerViewController: UIViewController {
    
    //오디오 재생기
    var audioPlayer:AVAudioPlayer?
    
    //오디오 재생 버튼
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.title(for: .normal) == "음악 재생 시작" {
            sender.setTitle("음악 재생 중지", for: .normal)
            //오디오를 백그라운드에서도 재생할 수 있도록 옵셜 추가
            let session = AVAudioSession.sharedInstance()
            do {
                try session.setCategory(AVAudioSession.Category.playback, mode: .default, policy: AVAudioSession.RouteSharingPolicy.longFormAudio, options: [])
            } catch let error {
                fatalError("*** Unable to set up the audio session: \(error.localizedDescription) ***")
            }
            //오디오 재생
            if let player = audioPlayer {
                player.play()
            }
        } else {
            sender.setTitle("음악 재생 시작", for: .normal)
            //오디오 중지
            if let player = audioPlayer {
                player.stop()
            }
        }
    }
    
    //오디오 볼륨 조절 슬라이더
    @IBAction func sliderChangeVolum(_ sender: UISlider) {
        if audioPlayer != nil {
            let slider = sender
            audioPlayer?.volume = slider.value
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //오디오 플레이어 세팅
        audioPlayerSetting()
    }
    
    //오디오 플레이어 세팅
    func audioPlayerSetting() {
        //초기화 작업 //노래 파일 경로 생성
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "inception", ofType: "mp3")!, relativeTo: nil)
        //재생기 생성
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer!.prepareToPlay()
    }
}
