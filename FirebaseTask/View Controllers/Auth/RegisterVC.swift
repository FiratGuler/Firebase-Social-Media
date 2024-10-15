//
//  LogUpVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit
import SnapKit

class RegisterVC: UIViewController {
    
    let emailTextField = CustomTextField(placeholder: "Email...")
    let passwordTextField = CustomTextField(placeholder: "Password...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        // Email Text
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(42)
        }
        
        //Password Text
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.left.right.height.equalTo(emailTextField)
        }
        
        // Register Button
        let registerButton = CustomButton(titleName: "Register")
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.left.right.height.equalTo(emailTextField)
        }
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc private func registerButtonTapped() {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                
                DispatchQueue.main.async {
                    AuthManager.shared.registerNewUser(email: email, password: password) { result in
                        if result {
                            let verifacationVC = VerificationVC()
                            self.navigationController?.pushViewController(verifacationVC, animated: true)
                        }
                    }
                }
            }
        }
    }
    
}
