//
//  VerificationVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit
import SnapKit

class VerificationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI(){
        
        view.backgroundColor = .systemBackground
        
        // Message Label
        let messageLabel = UILabel()
        messageLabel.text = "Click the button for the verification mail and confirm your account in the incoming mail."
        messageLabel.font = UIFont.systemFont(ofSize: 18)
        messageLabel.numberOfLines = 3
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(32)
            make.height.equalTo(52)
        }
        
        // Send Mail Button
        let mailButton = CustomButton(titleName: "Send Mail")
        view.addSubview(mailButton)
        mailButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(52)
        }
        mailButton.addTarget(self, action: #selector(mailButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Selector
    
    @objc private func mailButtonTapped() {
        
        DispatchQueue.main.async {
            AuthManager.shared.verificationEmail { result in
                if result {
                    self.navigationController?.popToRootViewController(animated: true)
                }else {
                    AlertHelper.showAlert(viewController: self,
                                          title: "Error",
                                          message: "mail could not be sent.",
                                          actionTitle: "Ok")
                }
            }
        }
    }
    
}
