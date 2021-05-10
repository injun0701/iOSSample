//
//  MapUseViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/05/10.
//

import UIKit
import MapKit
import CoreLocation

class MapUseViewController: UIViewController {
    
    @IBOutlet var tfSearch: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    //위치 정보 사용을 위한 객체
    var locationManager: CLLocationManager?
    
    //검색 결과를 저장할 프로퍼티 생성
    var matchingItems = [MKMapItem]()
    
    //검색을 수행해주는 사용자 정의 함수
    func perfromSearch() {
        //기본 배열의 값을 모두 삭제
        matchingItems.removeAll()
        
        //로컬 검색 객체 생성
        let request = MKLocalSearch.Request()
        
        //검색어와 검색 영역을 설정
        request.naturalLanguageQuery = tfSearch.text
        request.region = mapView.region
        
        //로컬 검색 객체 생성
        let search = MKLocalSearch(request: request)
        //검색 시작
        search.start(completionHandler: {(response: MKLocalSearch.Response!, error: Error!) in
            //에러가 발생한 경우
            if error != nil {
                NSLog("Error:\(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                NSLog("검색된 데이터가 없음")
            } else {
                NSLog("데이터 검색 성공")
                
                for item in response.mapItems as [MKMapItem] {
                    if item.name != nil {
                        NSLog("이름=\(item.name!)")
                    }
                    if item.phoneNumber != nil {
                        NSLog("이름=\(item.phoneNumber!)")
                    }
                    
                    //지도에 마커를 출력
                    self.matchingItems.append(item as MKMapItem)
                    //맵에 출력할 어노테이션 생성
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
    
    //검색어를 입력받는 tf에서 리턴키를 눌렀을 때 호출되는 메소드
    @IBAction func tfSearchReturnAction(_ sender: UITextField) {
        //키보드를 제거
        tfSearch.resignFirstResponder()
        //맵 뷰에 출력한 기존 어노테이션 제거
        mapView.removeAnnotations(mapView.annotations)
        //사용자 정의 메소드 호출
        self.perfromSearch()
    }
    
    //맵 타입 토글 버튼
    @IBAction func btnTypeAction(_ sender: UIButton) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
    }
    
    //맵 줌 버튼
    @IBAction func btnZoomAction(_ sender: UIButton) {
        //현재 위치를 기준으로 반경 3km
        mapZoom(latitudinalMeters: 3000, longitudinalMeters: 3000)
    }
    
    //검색 결과 리스트 화면으로 이동하는 버튼
    @IBAction func btnToSearchResultAction(_ sender: UIButton) {
        let sb = UIStoryboard(name: "MapUse", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "MapResultListViewController") as! MapResultListViewController
        navi.mapItem = matchingItems
        navigationController?.pushViewController(navi, animated: true)
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
        //위치 정보 사용을 위한 객체 생성
        locationManager = CLLocationManager()
        
        //위치 정보 사용을 위한 메소드 호출
        //앱이 실행 중인 동안만 위치 정보 사용
        locationManager?.requestWhenInUseAuthorization()
        
        //맵뷰가 현재 위치를 사용할 수 있도록 설정
        mapView.showsUserLocation = true
        
        mapView.delegate = self
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //현재 위치를 기준으로 반경 30km
        mapZoom(latitudinalMeters: 30000, longitudinalMeters: 30000)
    }
    
    func mapZoom(latitudinalMeters: Double, longitudinalMeters: Double) {
        //위치 권한 허용 체크 - 아니요 눌렀을때 클로져 처리
        locationCheck {}
        //위치 권한 버튼을 클릭해야지 다음 함수 실행
        LocationManager.sharedInstance.runLocationBlock { [self] in

            //현재 위치 가져오기
            let userLocation = mapView.userLocation
            
            if userLocation.location != nil {
                //지도의 출력 크기 설정
                let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: longitudinalMeters)
                //맵뷰 영역 설정
                mapView.setRegion(region, animated: true)
            }
        }
    }
}

extension MapUseViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
}
