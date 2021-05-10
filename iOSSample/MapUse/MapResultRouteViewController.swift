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
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestLocation()
        
    }
    
    func showRoute(_ response: MKDirections.Response) {
        for route in response.routes {
            mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            for step in route.steps {
                print(step.instructions)
                
            }
            
        }
        if let coordinate = userLocation?.coordinate {
            let region = MKCoordinateRegion(center:coordinate, latitudinalMeters:2000, longitudinalMeters:2000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        
        if let destination = destination {
            request.destination = destination
        }
        request.requestsAlternateRoutes = false
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {(response, error) in
            if let error = error {
                print(error.localizedDescription)
                //로딩 중지
                self.hud.dismiss(afterDelay: 0.4)
            } else {
                if let response = response {
                    self.showRoute(response)
                    //로딩 중지
                    self.hud.dismiss(afterDelay: 0.4)
                }
            }
        })
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
}
