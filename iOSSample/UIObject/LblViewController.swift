//
//  LblViewController.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/21.
//

import UIKit

class LblViewController: UIViewController {

    @IBOutlet var lblNickname: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblPhoneNumber: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblTalking: UILabel!
    @IBOutlet var lblRotation: UILabel!
    
    @IBAction func btnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textSetting()
    }
    
    func textSetting() {
        lblNickname.text = "iOS Master"
        let fontSize = UIFont.boldSystemFont(ofSize: 30)
        let attributedString = NSMutableAttributedString(string: lblNickname.text!)
        attributedString.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSize, range: (lblNickname.text! as NSString).range(of:"iOS"))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: (lblNickname.text! as NSString).range(of:"iOS"))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: (lblNickname.text! as NSString).range(of:"iOS"))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.blue, range: (lblNickname.text! as NSString).range(of:"iOS"))
        lblNickname.attributedText = attributedString
        
        lblMessage.text = "ios 앱을 만들어보자"
        lblPhoneNumber.text = "010-1111-1111"
        lblPhoneNumber.textAlignment = .right
        lblEmail.text = "we7000@hanmail.net"
        lblEmail.textAlignment = .right
        lblTalking.text = "아름다운 금수강산 무궁화 삼천리 화려강산 대한사랑 대한으로 길이 보전하세"
        lblTalking.textColor = .lightGray
        let attrString = NSMutableAttributedString(string:lblTalking.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0,attrString.length))
        
        lblTalking.attributedText = attrString
        lblTalking.sizeToFit()
        
        //회전
        lblRotation.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2.0)
        //보더
        lblRotation.layer.borderWidth = 3.0
        lblRotation.layer.borderColor = UIColor.magenta.cgColor
    }

}
