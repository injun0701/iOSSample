//
//  AudioRecordViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/11.
//

import UIKit
import AVFoundation

class AudioRecordViewController: UIViewController {
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var btnPlay: UIButton!
    
    //오디오 재생기
    var audioPlayer:AVAudioPlayer?
    //오디오 녹음기
    var audioRecorder: AVAudioRecorder?
    
    //오디오 녹음 버튼
    @IBAction func btnRecordAction(_ sender: UIButton) {
        if sender.title(for: .normal) == "음원 녹음 시작" {
            sender.setTitle("음원 녹음 중지", for: .normal)
            
            ///오디오 녹음 중지
            if audioRecorder?.isRecording == false {
                btnPlay.isEnabled = false
                audioRecorder?.record()
            }
        } else {
            sender.setTitle("음원 녹음 시작", for: .normal)
            
            //오디오 녹음 중지
            if audioRecorder?.isRecording == true {
                btnPlay.isEnabled = true
                audioRecorder?.stop()
            } else {
                audioPlayer?.stop()
            }
        }
    }
    
    //오디오 재생 버튼
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.title(for: .normal) == "음원 재생 시작" {
            sender.setTitle("음원 재생 중지", for: .normal)
            if audioRecorder?.isRecording == false {
                btnRecord.isEnabled = false
                btnPlay.isEnabled = true
                
                //녹음 파일 재생
                audioPlayer = try! AVAudioPlayer(contentsOf: audioRecorder!.url)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                
            }
        } else {
            sender.setTitle("음원 재생 시작", for: .normal)
            if audioRecorder?.isRecording == false {
                btnRecord.isEnabled = true
                btnPlay.isEnabled = true
                
                //녹음 파일 중지
                audioPlayer?.stop()
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
        //재생 버튼 비활성화
        btnPlay.isEnabled = false
        
        //녹음 파일 저장
        let dirPaths = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true)
        let docsDir = dirPaths[0]
        let soundFilePath = docsDir + "/sound.caf"
        let soundFileURL = URL(fileURLWithPath: soundFilePath)
        let recordSettings:[String:Any] = [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue, AVEncoderBitRateKey: 16, AVNumberOfChannelsKey: 2, AVSampleRateKey: 44100.0]

        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSession.Category.playAndRecord)

        audioRecorder = try! AVAudioRecorder(url: soundFileURL, settings: recordSettings)
        audioRecorder?.prepareToRecord()
    }
}

extension AudioRecordViewController: AVAudioPlayerDelegate{
    //오디오 재생이 끝났을때
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlay.setTitle("음원 재생 시작", for: .normal)
        //녹음 버튼 활성화
        btnRecord.isEnabled = true
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    //오디오 녹음이이 끝났을때
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }

}
