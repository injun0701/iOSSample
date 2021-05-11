//
//  MapResultRouteViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/10.
//

import UIKit
import MapKit
import JGProgressHUD

class MapResultRouteViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    //하나의 위치 정보를 저장할 프로퍼티 - 이전 뷰 컨트롤러에서 전달
    var destination: MKMapItem?
    
    //현재 위치를 저장할 프로퍼티
    var userLocation: CLLocation?
    
    //위치 정보 사용을 위한 객체 생성
    var locationManager = CLLocationManager()
    
    //로딩 객체
    let hud = JGProgressHUD()
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    
    func setting() {
        //로딩 시작
        hud.show(in: self.view)
        //맵뷰에 이벤트 발생시 현재 클래스의 인스턴스가 처리
        mapView.delegate = self
        //맴뷰가 현재 위치 사용 설정
        mapView.showsUserLocation = true
        
        //위치 정보 최고 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 정보에 이벤트 발생 시 현재 클래스의 인스턴스가 처리
        locationManager.delegate = self
        //위치 정보를 사용하는 시점을 설정
        locationManager.requestLocation()
        
    }
    
}

extension MapResultRouteViewController: MKMapViewDelegate {
    //mapView에 그래픽을 출력하는 메소드
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.blue
        render.lineWidth = 4.0
        return render
    }
    
}

extension MapResultRouteViewController: CLLocationManagerDelegate {
    //위치 정보가 갱신되었을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치 권한 허용 체크 - 아니요 눌렀을때 클로져 처리
        locationCheck {}
        //위치 권한 버튼을 클릭해야지 다음 함수 실행
        LocationManager.sharedInstance.runLocationBlock { [self] in
            //현재 위치 변경
            userLocation = locations[0]
            //사용자 정의 메소드 호출
            self.getDirections()
        }
    }
    
    //위치 정보를 가져오는데 실패했을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(error.localizedDescription)
    }
    
    //경로 결과 받아오기 사용자 정의 메소드
    func getDirections() {
        //출발지 정보 설정
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        //목적지 정보 설정
        if let destination = destination {
            request.destination = destination
        }
        //방대평 방향은 사용하지 않음
        request.requestsAlternateRoutes = false
        //요청
        let directions = MKDirections(request: request)
        //요청 결과 사용
        directions.calculate(completionHandler: {(response, error) in
            if let error = error {
                print(error.localizedDescription)
                //로딩 중지
                self.hud.dismiss(afterDelay: 0.4)
            } else {
                if let response = response {
                    //경로 설정 사용자 정의 메소드
                    self.showRoute(response)
                    //로딩 중지
                    self.hud.dismiss(afterDelay: 0.4)
                }
            }
        })
    }
    
    //경로 설정 사용자 정의 메소드
    func showRoute(_ response: MKDirections.Response) {
        //해당 경로를 받아서 순서대로
        for route in response.routes {
            //맵뷰 위에 선을 그리라고 요청
            mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            //동선을 문자열로 출력
            for step in route.steps {
                print(step.instructions)
            }
        }
        //맵뷰의 출력 영역을 변경
        if let coordinate = userLocation?.coordinate {
            let region = MKCoordinateRegion(center:coordinate, latitudinalMeters:2000, longitudinalMeters:2000)
            mapView.setRegion(region, animated: true)
        }
    }
}
