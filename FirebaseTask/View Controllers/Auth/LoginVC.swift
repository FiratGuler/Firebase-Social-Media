//
//  LogInVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit
import SnapKit


class LoginVC: UIViewController {
    
    let emailTextField = CustomTextField(placeholder: "Email...")
    let passwordTextField = CustomTextField(placeholder: "Password...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "LOG IN"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalToSuperview().offset(52)
            make.right.equalToSuperview().offset(-52)
            make.height.equalTo(52)
        }
        
        // Email TextField
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(52)
            make.left.right.height.equalTo(titleLabel)
        }
        
        //Password TextField
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(32)
            make.left.right.height.equalTo(titleLabel)
        }
        
        //Log In Button
        let logInButton = CustomButton(titleName: "Log In")
        view.addSubview(logInButton)
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.left.right.height.equalTo(titleLabel)
        }
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        
        //Register Button
        let registerButton = UIButton()
        registerButton.setTitle("Have you registered before?", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(32)
            make.left.right.height.equalTo(titleLabel)
        }
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        //Forgot Password Button
        let forgotPasswordButton = UIButton()
        forgotPasswordButton.setTitle("Forgot My Password", for: .normal)
        forgotPasswordButton.setTitleColor(.gray, for: .normal)
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(32)
            make.left.right.height.equalTo(titleLabel)
        }
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc private func logInButtonTapped() {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                
                AuthManager.shared.logInUser(email: email, password: password) { result in
                    if result {
                        let tabBarVC = CustomTabBar()
                        
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            if let window = windowScene.windows.first {
                                window.rootViewController = tabBarVC
                                window.makeKeyAndVisible()
                            }
                        }
                    }else {
                        AlertHelper.showAlert(viewController: self,
                                              title: "Error",
                                              message: "Try Again",
                                              actionTitle: "Ok")
                    }
                }
                
            }
        }
    }
    
    @objc private func registerButtonTapped() {
        let registerVC = RegisterVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func forgotPasswordButtonTapped() {
        if let email = emailTextField.text {
            AuthManager.shared.resetPassword(email: email) { result in
                AlertHelper.showAlert(viewController: self,
                                      title: "Message",
                                      message: result,
                                      actionTitle: "Ok")
            }
        }
    }
    
    
}
