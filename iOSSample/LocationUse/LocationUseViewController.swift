//
//  LocationUseViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/10.
//

import UIKit
import CoreLocation

class LocationUseViewController: UIViewController {
    @IBOutlet var lblLatitude: UILabel!
    @IBOutlet var lblLongitude: UILabel!
    @IBOutlet var lblAltitude: UILabel!
    @IBOutlet var lblDistance: UILabel!
    
    //위치정보 객체 생성
    var locationManager: CLLocationManager = CLLocationManager()
    
    //첫번째 위치를 저장할 프로퍼티
    var startLocation: CLLocation!
    
    //영역에 대한 정보를 저장할 프로퍼티
    var region: CLCircularRegion!
    
    @IBAction func updateLocation(_ sender: UIButton) {
        //이벤트가 발생한 객체를 가져오기
        let btn = sender
        //위치 권한 허용 체크 - 아니요 눌렀을때 클로져 처리
        locationCheck {}
        //위치 권한 버튼을 클릭해야지 다음 함수 실행
        LocationManager.sharedInstance.runLocationBlock { [self] in
            OperationQueue.main.addOperation {
                if btn.title(for: .normal) == "위치정보수집시작" {
                    btn.setTitle("위치정보수집중지", for: .normal)
                    //위치정보 업데이트 시작
                    locationStartSetting()
                    //위치 영역 감지 시작
                    locationRegionStartSetting()
                } else {
                    btn.setTitle("위치정보수집시작", for: .normal)
                    //위치정보 업데이트 중지
                    locationStopSetting()
                    //위치 영역 감지 중지
                    locationRegionStopSetting()
                }
            }
        }
    }
    
    //위치정보 업데이트 시작
    func locationStartSetting() {
        //위치정보 사용이 가능하면
        if CLLocationManager.locationServicesEnabled() {
            //배터리에 맞게 권장되는 최적의 정확도
            //locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            //위치정보 업데이트 시작
            locationManager.startUpdatingLocation()
        }
    }
    
    //위치정보 업데이트 중지
    func locationStopSetting() {
        locationManager.stopUpdatingLocation()
    }
    
    //위치 영역 감지 시작
    func locationRegionStartSetting() {
        //영역 설정
        //중점의 좌표 설정
        let center = CLLocationCoordinate2D(latitude: 37.5690886, longitude: 126.984652)
        //윈의 거리 - 1km
        let maxDistance = 1000.0
        //영역을 생성
        region = CLCircularRegion(center: center, radius: maxDistance, identifier: "종료")
        //영역을 감지 시작
        locationManager.startMonitoring(for: region)
    }
    
    //위치 영역 감지 중지
    func locationRegionStopSetting() {
        //영역을 감지 중지
        locationManager.startMonitoring(for: region)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //위치정보 세팅
        loactionSetting()
    }
    
    //위치정보 세팅
    func loactionSetting() {
        //locationManager의 delegate 설정 - locationManager만의 이벤트가 발생했을 때 호출될 메소드를 소유한 객체를 지정
        //안드로이드 나 Java GUI의 Listener 지정
        locationManager.delegate = self
        
        //위치 정보 사용을 위한 메소드 호출
        //앱이 실행 중인 동안만 위치 정보 사용
        locationManager.requestWhenInUseAuthorization()
    }
}

//MARK: LocationUseViewController
extension LocationUseViewController: CLLocationManagerDelegate {
    
    //위치정보를 가져오는데 성공했을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //가장 마지막 위치 정보를 가져오기
        let latestLocation = locations[locations.count - 1]
        
        //위치 정보 가져오기
        let coordinate = latestLocation.coordinate
        
        //출력 - 위도, 경도, 고도
        lblLatitude.text = String(format: "%.4f", coordinate.latitude)
        lblLongitude.text = String(format: "%.4f", coordinate.longitude)
        lblAltitude.text = String(format: "%.4f", latestLocation.altitude)
        
        //시작위치 설정
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        //이동한 거리 계산
        let distance = latestLocation.distance(from: startLocation)
        lblDistance.text = String(format: "%.2f", distance)
    }
    
    //위치정보를 가져오는데 실패했을 때 호출 되는 메소드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlertBtn1(title: "위치정보", message: "위치정보 가져왹 실패", btnTitle: "확인") {}
    }
    
    //영역에 들어온 경우 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        showAlertBtn1(title: "위치정보", message: "종로에 들어왔습니다.", btnTitle: "확인") {}
    }
    
    //영역에 나가는 경우 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlertBtn1(title: "위치정보", message: "종로에서 나갔습니다.", btnTitle: "확인") {}
    }
}
