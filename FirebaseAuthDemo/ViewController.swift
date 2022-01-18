//
//  ViewController.swift
//  FirebaseAuthDemo
//
//  Created by 강호성 on 2022/01/18.
//

import UIKit
import FirebaseAuth

// TODO
// 번호인증 만료 타이머
// 버튼 유효성 검사 (rx 적용)

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var varificationCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func handleSendButton(_ sender: UIButton) {
        let phoneNumber = phoneNumberTextField.text ?? ""
        
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
              if error == nil {
                  print("verificationID: \(verificationID ?? "")")
                  UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
              } else {
                  print("Phone Varification Error: \(error.debugDescription)")
              }
          }
    }
    
    @IBAction func handleDoneButton(_ sender: UIButton) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        let verificationCode = varificationCodeTextField.text ?? ""
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                print(success ?? "")
                print("사용자 로그인!")
            } else {
                print("Login failed: \(error.debugDescription)")
            }
        }
    }
    
    
}

