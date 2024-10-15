//
//  ProfileVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    let badgeImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        checkVerifiedEmail()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(systemName: "arrow.circlepath"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightBarButtonTapped))
        
        // Verified badge
        badgeImage.image = UIImage(systemName: "person.crop.circle.badge.checkmark")
        badgeImage.tintColor = .gray
        view.addSubview(badgeImage)
        badgeImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        // Verified Info Label
        let infoLabel = UILabel()
        infoLabel.text = "If the mail is approved, the icon will be blue."
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(badgeImage.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(52)
        }
        
        // Email Send Button
        let sendMailButton = CustomButton(titleName: "Send verified mail")
        view.addSubview(sendMailButton)
        sendMailButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(80)
            make.left.right.height.equalTo(infoLabel)
        }
        sendMailButton.addTarget(self, action: #selector(sendMailButtonTapped), for: .touchUpInside)
        
        //Log Out Button
        let logoutButton = CustomButton(titleName: "Log Out")
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(sendMailButton.snp.bottom).offset(52)
            make.left.right.height.equalTo(infoLabel)
        }
        logoutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
    }
    
    private func checkVerifiedEmail() {
        guard let user = Auth.auth().currentUser else {return}
        
        user.reload { error in
            if let error = error {
                print("Kullanıcı bilgileri güncellenemedi: \(error.localizedDescription)")
                return
            }else {
                
                if user.isEmailVerified {
                    self.badgeImage.tintColor = .blue
                }else {
                    self.badgeImage.tintColor = .gray
                }
                
            }
        }
        
    }
    private func logOutUser() {
        AuthManager.shared.logOut()
        let loginVC = LoginVC()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = loginVC
                window.makeKeyAndVisible()
            }
        }
    }
    
    // MARK: - Selector
    @objc private func sendMailButtonTapped() {
        AuthManager.shared.verificationEmail { result in
            if result {
                AlertHelper.showAlert(viewController: self,
                                      title: "Send",
                                      message: "Control Email",
                                      actionTitle: "Ok")
            }
        }
    }
    
    @objc private func logOutButtonTapped() {
        
        AlertHelper.showAlert(viewController: self,
                              title: "Log Out",
                              message: "Log out...",
                              actionTitle: "LogOut") { self.logOutUser() }
    }
    
    @objc private func rightBarButtonTapped() {
        guard let user = Auth.auth().currentUser else {return}
        user.reload()
    }
    
}

