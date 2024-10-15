//
//  UploadPhotoVC.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 8.10.2024.
//

import UIKit
import SnapKit

class UploadPhotoVC: UIViewController {
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // imageview
        imageView.image = UIImage(systemName: "photo.badge.plus")
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .black
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageTap)
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(200)
        }
        
        // upload Button
        let uploadButton = CustomButton(titleName: "Upload")
        view.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(52)
        }
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Selector
    
    @objc private func imageTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func uploadButtonTapped() {
        guard let image = imageView.image else {return}
        
        StorageManager.shared.saveImage(image: image) { comp in
            if comp {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
}

extension UploadPhotoVC :  UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
extension UploadPhotoVC :  UINavigationControllerDelegate {
    
}
