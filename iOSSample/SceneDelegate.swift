//
//  SceneDelegate.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit
//로컬 알림을 사용하기 위한 프레임워크 import
import UserNotifications

//이 클래스는 앱이 실행될 때 AppDelegate가 호출되고
//화면이 보여지기 전에 호출되어 화면을 만드는 역할을 하는 클래스
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    //AppDelegate에 의해서 SceneDelegate가 호출될 때 실행되는 메소드
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //알림창 등록
        let notificationCenter = UNUserNotificationCenter.current()
        //알림 권한 신청
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(didAllow, e) -> Void in })
        //알림이 왔을 떄 호출될 메소드의 위치를 설정
        notificationCenter.delegate = self
      
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    //앱의 화면이 안보이게 될 때 호출되는 메소드
    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    //앱이 백그라운드로 진입할때 호출되는 메소드
    func sceneDidEnterBackground(_ scene: UIScene) {
        //로컬 알림 메시지 보내기
        UNUserNotificationCenter.current().getNotificationSettings { (setting) -> Void in
            //알림을 사용할 권한이 있는지 체크
            if setting.authorizationStatus == UNAuthorizationStatus.authorized { //권한 있음
                //알림 콘텐츠 생성
                let nContent = UNMutableNotificationContent()
                nContent.badge = 1
                nContent.title = "앱 알림" //로컬 알림 메시지 제목
                //nContent.subtitle = "하위 제목" //하위 제목
                nContent.body = "앱이 백그라운드 상태가 되었습니다." //로컬 알림 메시지 내용
                nContent.sound = UNNotificationSound.default
                //부가 정보 - 알림 객체에게 전달할 데이터
                nContent.userInfo = ["name":"관리자"]
                
                //알림 발생 조건 생성
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
                
                //알림 요청 객체 생성
                let request = UNNotificationRequest(identifier: "구별할 이름", content: nContent, trigger: trigger)
                
                //알림 등록
                UNUserNotificationCenter.current().add(request)
                
            } else { //권한 없음
                NSLog("알림 사용 권한을 선택하지 않았습니다.")
            }
        }
    }
}

extension SceneDelegate: UNUserNotificationCenterDelegate {
    //알림이 오면 호출되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //알람이 오면 구별할 이름을 확인해서 실행
        if notification.request.identifier == "구별할 이름" {
            //부가 정보를 가져온 후 name 값을 출력
            let userInfo = notification.request.content.userInfo
            NSLog("\(userInfo["name"]!)")
        }
        //알림 배너 출력
        completionHandler([.badge, .badge, .sound])
    }
    
    //알림이 메시지를 누르면 호출되는 메소드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //알람이 오면 구별할 이름을 확인해서 실행
        if response.notification.request.identifier == "구별할 이름" {
            //부가 정보를 가져온 후 name 값을 출력
            let userInfo = response.notification.request.content.userInfo
            NSLog("\(userInfo["name"]!)")
            
            //Badge 카운트 0으로 만들기
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        completionHandler()
    }
}
