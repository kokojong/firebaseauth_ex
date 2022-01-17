//
//  ViewController.swift
//  SeSAC_week17_Firebase_auth
//
//  Created by kokojong on 2022/01/17.
//

import UIKit
import Firebase
import SnapKit

class ViewController: UIViewController{
    
    var phoneNumber = ""
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호를 입력해주세요"
        textField.backgroundColor = .lightGray
        
        return textField
    }()
    
    let codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "인증번호를 입력해주세요"
        textField.backgroundColor = .lightGray
        
        return textField
    }()
    
    let sendCodeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.tintColor = .black
        button.setTitle("인증번호 보내기", for: .normal)
        
        return button
        
    }()
    
    let checkCodeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("인증번호 확인", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        addConstraints()
        
        phoneTextField.addTarget(self, action: #selector(onPhoneTextFieldChanged), for: .editingChanged)
        sendCodeButton.addTarget(self, action: #selector(onSendCodeButtonClicked), for: .touchUpInside)
        
        Auth.auth().languageCode = "kr"
        
        
        
        
    }
    
    func addViews() {
        self.view.addSubview(phoneTextField)
        self.view.addSubview(codeTextField)
        self.view.addSubview(sendCodeButton)
        self.view.addSubview(checkCodeButton)
    }
    
    func addConstraints() {
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        sendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(sendCodeButton.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        checkCodeButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }
    
    @objc func onSendCodeButtonClicked() {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                print("verificationID ",verificationID)
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
            }
        
//        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        
//        let credential = PhoneAuthProvider.provider().credential(
//          withVerificationID: verificationID,
//          verificationCode: verificationCode
//
//        )
    }

    @objc func onPhoneTextFieldChanged() {
        phoneNumber = phoneTextField.text ?? ""
        print(phoneNumber)
    
    }
    
    
}

