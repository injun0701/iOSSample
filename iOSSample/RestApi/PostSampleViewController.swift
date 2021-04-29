//
//  PostSampleViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/29.
//

import UIKit
import Alamofire
import Photos

class PostSampleViewController: UIViewController {
    
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfPrice: UITextField!
    @IBOutlet var tfDescription: UITextField!
    
    //이미지 이름(초기화)
    var imageName = "gray.jpg"
    //이미지 확장자(초기화)
    var imageDataFileExtension = "jpg"
    
    //앨범 객체 생성
    let imagePickerController = UIImagePickerController()
    
    @IBAction func btnImgAction(_ sender: UIButton) {
        
        //카메라 권한 허용 체크
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            
            print("permission: 권한 허용")
            OperationQueue.main.addOperation {
                self.imagePickerController.sourceType = .photoLibrary
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
            
        case  .restricted, .denied:
            
            print("permission: 권한 거부")
            goToCameraSetting()
            
        case .notDetermined:
            
            print("permission: 선택 안함")
            //카메라 권한 허용 띄우기
            PHPhotoLibrary.requestAuthorization { state in
                if state == .authorized {
                    //스레드 이용해야 동작함
                    OperationQueue.main.addOperation {
                        self.imagePickerController.sourceType = .photoLibrary
                        self.present(self.imagePickerController, animated: true, completion: nil)
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        default:
            break
        }
        
    }
    
    //카메라 설정 화면 이동 얼럿
    func goToCameraSetting() {
        //대화상자로 출력하기
        showAlertBtn2(title: "카메라 권한", message: "카메라 권한 허용이 필요합니다. 설정화면으로 이동하시겠습니까?", btn1Title:  "이동", btn2Title: "취소") {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        } btn2Action: {}
    }
    
    @IBOutlet var imgView: UIImageView!
    
    //업로드 버튼 동작
    @IBAction func btnPostAction(_ sender: UIButton) {
        
        if tfTitle.text == "" ||  tfPrice.text == "" || tfDescription.text == "" {
            showAlertBtn1(title: "입력 오류", message: "빈칸이 없게 모두 작성해 주세요.", btnTitle: "확인") {}
        } else {
            //업로드
            insert()
        }
       
    }
    
    //이미지의 이름에서 확장자 체크
    func imageDataCheck() -> Data? {
        let image = imgView.image
        
        if imageName.contains(".jpg") {
            print("이미지 이름 : \(imageName)")
            //jpg파일이면 jpegData()로 imageData세팅
            let imageData = image?.jpegData(compressionQuality: 0.5)
            
            //이미지 확장자 "jpg"
            imageDataFileExtension = "jpg"
            
            return imageData!
            
        } else if imageName.contains(".jpeg")  {
            print("이미지 이름 : \(imageName)")
            //jpeg파일이면 jpegData()로 imageData세팅
            let imageData = image?.jpegData(compressionQuality: 0.5)
            
            //이미지 확장자 "jpeg"
            imageDataFileExtension = "jpeg"
            
            return imageData!
            
        } else if imageName.contains(".png")  {
            print("이미지 이름 : \(imageName)")
            //png파일이면 pngData()로 imageData세팅
            let imageData = image?.pngData()
            
            //이미지 확장자 "png"
            imageDataFileExtension = "png"
            
            return imageData!
            
        } else {
            return nil
        }
    }
    
    //업로드 함수
    func insert() {
        //이미지 데이터가 nil이 아니면
        if let imageData = imageDataCheck() {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "yyyy-MM-dd"
            let date = dateFormatter.string(from: Date())
            
            let url = "http://cyberadam.cafe24.com/item/insert"
            
            AF.upload(multipartFormData: { [self] multipartFormData in //알라모파이어로 업로드
                
                multipartFormData.append(Data(tfTitle.text!.utf8), withName: "itemname")
                multipartFormData.append(Data(tfPrice.text!.utf8), withName: "price")
                multipartFormData.append(Data(tfDescription.text!.utf8), withName: "description")
                multipartFormData.append(Data(date.utf8), withName: "updatedate")
                
                //이미지파일 전송
                multipartFormData.append(imageData, withName: "pictureurl", fileName: self.imageName, mimeType: "image/\(imageDataFileExtension)")
                
            }, to: url).responseJSON { response in //결과값 받기
                
                if let jsonResult = response.value as? [String: Any] {
                    let result = jsonResult["result"] as! Int
                    NSLog("결과:\(result)")
                    if result == 1 { //업로드 성공
                        self.showAlertBtn2(title: "업로드 성공", message: "업로드 성공했습니다.", btn1Title: "결과 확인", btn2Title: "확인") {
                            //결과 화면으로 이동
                            self.ToRestfulApiSample()
                        } btn2Action: {}
                    } else { //업로드 실패
                        self.showAlertBtn1(title: "업로드 실패", message: "업로드 실패했습니다.", btnTitle: "확인") {}
                    }
                }
            }
        } else { //이미지 데이터가 nil이면
            print("이미지 이름 : \(imageName)")
            showAlertBtn1(title: "업로드 오류", message: "확장자가 jpg, png만 업로드 가능합니다.", btnTitle: "확인") {}
        }
        
    }
    
    @IBAction func btnToRestfulApiSampleAction(_ sender: UIButton) {
        //결과 화면으로 이동
        ToRestfulApiSample()
    }
    
    //결과 화면으로 이동
    func ToRestfulApiSample() {
        let sb = UIStoryboard(name: "RestApi", bundle: nil)
        let navi = sb.instantiateViewController(withIdentifier: "PostSampleResultViewController") as! PostSampleResultViewController
        navigationController?.pushViewController(navi, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSetting()
    }
    
    func imageSetting() {
        imagePickerController.delegate = self
        
        let image = UIImage(named: imageName)
        imgView.image = image
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

}

extension PostSampleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageDataName = "\(info[UIImagePickerController.InfoKey.imageURL] ?? "gray.jpg")"
            //문자열 끝에서 10글자 추출
            let imageDataNameStr = "\(imageDataName.suffix(10))"
            imageName = "\(imageDataNameStr)"
            print(imageName)
            imgView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
